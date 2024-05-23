import 'dart:convert';

import 'package:chambeape/infrastructure/models/users.dart';
import 'package:chambeape/presentation/screens/chat/chat_view.dart';
import 'package:chambeape/services/chat/message_service.dart';
import 'package:chambeape/services/users/user_service.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chambeape/infrastructure/models/chat_message.dart' as Message;
import 'package:stomp_dart_client/stomp_dart_client.dart';

late List<Users> users;
late List<String> lastMsgsTime;
int unreadMessagesCount = 0;

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});
  static const String routeName = 'chat_list';

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  late Future<List<Users>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUsers();
    lastMsgsTime = List.filled(30, ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: FutureBuilder(
        future: futureUsers, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          else if (snapshot.hasData) {
            users = snapshot.data!;
            
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Users user = users[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                      title: Row(
                        children: [
                          Text("${user.firstName.split(' ')[0]} ${user.lastName}", 
                          maxLines: 1,
                          overflow: TextOverflow.fade,),
                          Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              lastMsgsTime[index],
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12 
                              ),
                            ),
                          ),
                        )
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(child: LastMessage(otherUserIndex: index)),
                        ],
                      ), 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatView(otherUser: user,),
                          ),
                        );
                      },
                    ),
                    Divider(
                      indent: 70,
                      thickness: 0.2,
                      color: Colors.grey.shade800,
                      height: 7,
                    )
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text('No users found'));
          }
        }
        ),
    );
  }
}

class LastMessage extends StatefulWidget {
  final int otherUserIndex;
  const LastMessage({super.key, required this.otherUserIndex});

  @override
  State<LastMessage> createState() => _LastMessageState();
}

class _LastMessageState extends State<LastMessage> {
  late int otherUserIndex;
  late Future<void> loadMessageDetailsFuture;
  late Users? currentUser;
  late Message.ChatMessage lastMessage;
  late String chatroomId;
  StompClient? stompClient;

  @override
  void initState() {
    super.initState();
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'https://chambeape-chat.azurewebsites.net/websocket',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );
    stompClient?.activate(); 
    otherUserIndex = widget.otherUserIndex;
    loadMessageDetailsFuture = loadMessageDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: loadMessageDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          } 
          else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return const Center(child: Text('Error loading chat. Please try again later'));
          } 
          else {
            TextStyle textStyle = TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 15,
                );
            switch(lastMessage.type){
              case 'text':
                return Text(
                  lastMessage.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                );
              case 'image':
                return Row(children: [
                Icon(
                  Icons.image,
                  size: 22,
                  color: Colors.grey.shade800,
                  ), 
                Text(
                  'Foto',
                  style: textStyle
                  )
                ],);
              default:
                return Row(children: [
                Icon(
                  Icons.file_copy,
                  size: 22,
                  color: Colors.grey.shade800,
                  ), 
                Text(
                  'Archivo',
                  style: textStyle
                  )
                ],);
            }  
          }
        }
      );
  }

  Future<void> loadMessageDetails() async{
    currentUser = await getCurrentUser();
    chatroomId = generateChatRoomId(currentUser!.id.toString(), users[otherUserIndex].id.toString());
    List<Message.ChatMessage> _lastMessage = await MessageService().getMessages(chatroomId, latest: true);
    DateTime dateTime = DateTime.parse(_lastMessage[0].timestamp);
    String formattedTime = '${dateTime.hour}:${dateTime.minute}';
    setState(() {
      lastMessage = _lastMessage[0];
      lastMsgsTime[otherUserIndex] = formattedTime;
    });
  }

  Future<Users?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      return Users.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  String generateChatRoomId(String currentUserId, String otherUserId) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String combinedIds = '${ids[0]}_${ids[1]}';
    var bytes = utf8.encode(combinedIds);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void onConnect(StompFrame frame) {
    stompClient?.subscribe(
      destination: '/topic/$chatroomId',
      callback: (frame) {
        if (frame.body != null) {
          setState(() {
            lastMessage = Message.ChatMessage.fromJson(jsonDecode(frame.body!));
            DateTime dateTime = DateTime.parse(lastMessage.timestamp);
            String formattedTime = '${dateTime.hour}:${dateTime.minute}';
            lastMsgsTime[otherUserIndex] = formattedTime;
            unreadMessagesCount++;
          });
        }
      },
    );
  }
}
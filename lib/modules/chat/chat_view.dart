import 'dart:convert';
import 'dart:io';

import 'package:chambeape/model/ChatMessage.dart' as Message;
import 'package:chambeape/services/chat/message_service.dart';
import 'package:crypto/crypto.dart';
import 'package:chambeape/model/Users.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:timezone/standalone.dart' as tz;

class ChatView extends StatefulWidget {
  final Users otherUser;

  const ChatView({super.key, required this.otherUser});
  static const String routeName = 'chat_view';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  StompClient? stompClient;
  late String roomId;
  late Message.ChatMessage lastMessage;
  late List<Message.ChatMessage> messages = [];
  late Users? currentUser, otherUser;
  late ChatUser? chatCurrentUser, chatOtherUser;
  late Future<void> loadChatFuture;

  @override
  void initState(){
    super.initState();
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'https://chambeape-chat.azurewebsites.net/websocket',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );

    stompClient?.activate(); 
    loadChatFuture = loadChat();
  }

  Future<void> loadChat() async{
    otherUser = widget.otherUser;
    currentUser = await getCurrentUser();
    loadChatUsers();
    roomId = generateChatRoomId(currentUser!.id.toString(), otherUser!.id.toString());
    await loadMessages();
  }

  Future<Users?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      return Users.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  void loadChatUsers() {
      chatCurrentUser = ChatUser(
        id: currentUser!.id.toString(), 
        firstName: currentUser!.firstName.split(' ')[0], 
        lastName: currentUser!.lastName.split(' ')[0],
        profileImage: currentUser!.profilePic,
    );
      chatOtherUser = ChatUser(
        id: otherUser!.id.toString(), 
        firstName: otherUser!.firstName.split(' ')[0], 
        lastName: otherUser!.lastName.split(' ')[0],
        profileImage: otherUser!.profilePic,
    );
  }

  String generateChatRoomId(String currentUserId, String otherUserId) {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String combinedIds = '${ids[0]}_${ids[1]}';
    var bytes = utf8.encode(combinedIds);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> loadMessages() async{
    List<Message.ChatMessage> loadedMessages = await MessageService().getMessages(roomId);
    setState(() {
      messages = loadedMessages;
    });
  }

  void onConnect(StompFrame frame) {
    stompClient?.subscribe(
      destination: '/topic/$roomId',
      callback: (frame) {
        if (frame.body != null) {
          setState(() {
            lastMessage = Message.ChatMessage.fromJson(jsonDecode(frame.body!));
            messages.add(lastMessage);
          });
        }
      },
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    String message = chatMessage.text;
    // String type = chatMessage.medias!.isNotEmpty ? 'media' : 'text';

    if (stompClient != null && stompClient!.connected) {
      stompClient?.send(
        destination: '/app/chat/$roomId',
        body: '{"content":"$message","type":"text","user":"${currentUser!.id.toString()}"}',
      );  
    }
  }

  List<ChatMessage> getMessagesList(){
    List<ChatMessage> chatMessages = messages.map((e) {
      DateTime localTime = convertToLocalTime(e.timestamp);

      return ChatMessage(
                  text: e.content,
                  user: e.user == chatCurrentUser!.id ? chatCurrentUser! : chatOtherUser!,
                  createdAt: localTime
                  );
    }).toList();

    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return chatMessages;
  }

  DateTime convertToLocalTime(String timestamp) {
    final lima = tz.getLocation('America/Lima');
    DateTime localizedLimaDt = tz.TZDateTime.from(DateTime.parse(timestamp), lima);
    return localizedLimaDt;
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.otherUser.firstName.split(' ')[0]} ${widget.otherUser.lastName.split(' ')[0]}'),
      ),
      body: FutureBuilder<void>(
        future: loadChatFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return const Center(child: Text('Error loading chat. Please try again later'));
          } 
          else {   
              return DashChat(
                messageOptions: const MessageOptions(
                  showOtherUsersAvatar: true,
                  showTime: true
                  ),
                inputOptions: InputOptions(
                  alwaysShowSend: true,
                  trailing: [mediaMessageButton()]
                  ),
                currentUser: chatCurrentUser!,
                onSend: sendMessage,
                messages: getMessagesList()
              );
          }
        },
      ),
    );
  }

  Widget mediaMessageButton() {
    return IconButton(
      icon: Icon(Icons.image, color: Theme.of(context).colorScheme.primary,),
      onPressed: () {
        // Implement media message sending
      },
    );
  }
}
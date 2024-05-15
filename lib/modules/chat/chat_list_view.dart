import 'package:chambeape/model/Users.dart';
import 'package:chambeape/modules/chat/chat_view.dart';
import 'package:chambeape/services/users/user_service.dart';
import 'package:flutter/material.dart';

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
            List<Users> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Users user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                  ),
                  title: Text("${user.firstName} ${user.lastName}"),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatView(otherUser: user,),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No users found'));
          }
        }
        ),
    );
  }
}
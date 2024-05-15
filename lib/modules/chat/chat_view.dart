import 'dart:convert';
import 'dart:io';

import 'package:chambeape/model/Users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';


class ChatView extends StatefulWidget {
  final Users otherUser;

  const ChatView({super.key, required this.otherUser});
  static const String routeName = 'chat_view';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  StompClient? stompClient;
  final TextEditingController _controller = TextEditingController();
  final String roomId = "testing";
  String lastMessage = '';
  late Users? currentUser;
  late Users? otherUser;

  @override
  void initState() {
    super.initState();
    otherUser = widget.otherUser;
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://192.168.0.10:8080/ws',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );

    stompClient?.activate();

    loadUser();
  }

  Future<Users?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      return Users.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> loadUser() async {
    Users? loadedUser = await getCurrentUser();
    setState(() {
      currentUser = loadedUser;
    });
    print(currentUser!.firstName + " " + otherUser!.firstName);
  }

  void onConnect(StompFrame frame) {
    stompClient?.subscribe(
      destination: '/topic/$roomId',
      callback: (frame) {
        if (frame.body != null) {
          setState(() {
            lastMessage = jsonDecode(frame.body!)['message'];
          });
          print(lastMessage);
        }
      },
    );
  }

  void sendMessage(String message) {
    if (stompClient != null && stompClient!.connected) {
      stompClient?.send(
        destination: '/app/chat/$roomId',
        body: '{"message":"$message","user":"${currentUser!.id.toString()}"}',
      );
    }
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // Aquí puedes agregar un widget para mostrar los mensajes
                child: Text(lastMessage),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Escribe tu mensaje',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sendMessage(_controller.text);
                _controller.clear();
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chambeape/model/ChatMessage.dart';


class MessageService{
  final String baseUrl = 'https://chambeape-chat.azurewebsites.net/api/chat/messages';

  Future<List<ChatMessage>> getMessages(String roomId) async{
    final uri = Uri.parse(baseUrl).replace(queryParameters: {'roomId': roomId});
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> body = json.decode(response.body);
      List<ChatMessage> messages = body.map((dynamic item) => ChatMessage.fromJson(item)).toList();
      return messages;
    }
    else {
      throw Exception('Failed to fetch messages: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }
}
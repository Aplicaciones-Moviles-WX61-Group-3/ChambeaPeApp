import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatListService{
  final String baseUrl = 'https://chambeape-chat.azurewebsites.net/api/chatroom';

  Future<List<String>> getExistingChatUsersId(String userId) async{
    String url = '$baseUrl/$userId/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<String> ids = json.decode(utf8.decode(response.bodyBytes)).cast<String>();
      return ids;
    }
    else {
      throw Exception('Failed to fetch userIds: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }
}
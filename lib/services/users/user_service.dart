import 'dart:convert';

import 'package:chambeape/model/Users.dart';
import 'package:http/http.dart' as http;

class UserService{
  final uri = Uri.parse('https://chambeape.azurewebsites.net/api/v1/users');

  Future<List<Users>> getUsers() async{
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Users> users = body.map((dynamic item) => Users.fromJson(item)).toList();
      return users;
    }
    else {
      throw Exception('Failed to fetch users: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }
}
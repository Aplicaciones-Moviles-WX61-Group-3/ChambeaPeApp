import 'package:chambeape/model/login.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Login> login(String email, String password) async {
  Map<String, dynamic> requestBody = {
    'email': email,
    'password': password,
  };

  final uri = Uri.parse('https://chambeape.azurewebsites.net/api/v1/users/login');

  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    return Login.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to login');
  }
}

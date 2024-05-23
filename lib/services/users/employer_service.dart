import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:chambeape/model/employers.dart';

Future<List<Employers>> getEmployers() async {
  final uri = Uri.parse('https://chambeape.azurewebsites.net/api/v1/employers');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    String body = utf8.decode(response.bodyBytes);
    List<dynamic> json = jsonDecode(body);
    List<Employers> employers =
        json.map((dynamic item) => Employers.fromJson(item)).toList();
    return employers;
  } else {
    throw Exception('Failed to load employers');
  }
}

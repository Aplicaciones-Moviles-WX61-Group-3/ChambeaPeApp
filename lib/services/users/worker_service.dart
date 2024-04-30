import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chambeape/model/Workers.dart';

Future<List<Workers>> getWorkers() async {
  final uri = Uri.parse('https://chambeape.azurewebsites.net/api/v1/workers');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    String body = utf8.decode(response.bodyBytes);
    List<dynamic> json = jsonDecode(body);
    List<Workers> workers =
        json.map((dynamic item) => Workers.fromJson(item)).toList();
    return workers;
  } else {
    throw Exception('Failed to load Workers');
  }
}
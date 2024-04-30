import 'dart:convert';

import 'package:chambeape/model/Post.dart';
import 'package:http/http.dart' as http;

class PostService{
  final uri = Uri.parse('https://chambeape.azurewebsites.net/api/v1/employers/30/posts');

  Future<Post> createPost(String title, String description, String subtitle, String imgUrl) async{
    Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
      'subtitle': subtitle,
      'imgUrl': imgUrl
    };

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Post.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to create post: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }

  Future<List<Post>> getPosts() async{
    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> body = json.decode(response.body);
      List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
      return posts;
    }
    else {
      throw Exception('Failed to fetch posts: Status Code ${response.statusCode}, Response Body: ${response.body}');
    }
  }
}
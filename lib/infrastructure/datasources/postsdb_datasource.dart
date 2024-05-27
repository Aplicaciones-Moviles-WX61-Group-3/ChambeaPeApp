import 'dart:convert';

import 'package:chambeape/config/constats/environmet.dart';
import 'package:chambeape/domain/datasources/posts_datasource.dart';
import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/infrastructure/mappers/post_mapper.dart';
import 'package:chambeape/infrastructure/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostsdbDatasource extends PostsDataSource {
  @override
  Future<List<Post>> getPosts() async {
    final Uri uri = await UriEnvironment.getPostUri();

    final response = await http.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> postsResponse = json.decode(utf8.decode(response.bodyBytes));
      final List<Post> posts = postsResponse.map((item) => PostMapper.postModelToEntity(PostModel.fromJson(item))).toList();

      return posts;
    } else {
      // Handle errors as needed
      throw Exception('Error fetching posts');
    }
  }
  
  @override
  Future<Post> createPost(Post post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }
  
  @override
  Future<void> deletePost(String id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }
  
  @override
  Future<Post> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
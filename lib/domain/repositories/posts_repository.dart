import 'package:chambeape/domain/entities/posts_entity.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
}
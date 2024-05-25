
import 'package:chambeape/domain/entities/posts_entity.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
}
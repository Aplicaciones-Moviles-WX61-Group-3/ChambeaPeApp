import 'package:chambeape/domain/entities/posts_entity.dart';

abstract class PostsRepository {
  Future<List<PostState>> getPosts();

  Future<PostState> createPost(PostState post);

  Future<PostState> updatePost(PostState post);

  Future<void> deletePost(String id);
}

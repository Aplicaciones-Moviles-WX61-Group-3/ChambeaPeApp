import 'package:chambeape/domain/entities/posts_entity.dart';

abstract class PostsDataSource {
  Future<List<PostState>> getPosts();

  Future<List<PostState>> getPostsByEmployerId(int employerId);

  Future<PostState> createPost(PostState post);

  Future<PostState> updatePost(PostState post);

  Future<void> deletePost(String id);
}

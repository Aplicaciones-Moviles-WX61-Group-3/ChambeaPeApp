import 'package:chambeape/domain/datasources/posts_datasource.dart';
import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/domain/repositories/posts_repository.dart';

class PostRepositoryImpl extends PostsRepository {
  final PostsDataSource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<List<PostState>> getPosts() {
    return datasource.getPosts();
  }

  @override
  Future<PostState> createPost(PostState post) {
    return datasource.createPost(post);
  }

  @override
  Future<void> deletePost(String id) {
    return datasource.deletePost(id);
  }

  @override
  Future<PostState> updatePost(PostState post) {
    return datasource.updatePost(post);
  }
}

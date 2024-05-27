import 'package:chambeape/domain/datasources/posts_datasource.dart';
import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/domain/repositories/posts_repository.dart';

class PostRepositoryImpl extends PostsRepository {

  final PostsDataSource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<List<Post>> getPosts() {
    return datasource.getPosts();
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

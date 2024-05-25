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
}

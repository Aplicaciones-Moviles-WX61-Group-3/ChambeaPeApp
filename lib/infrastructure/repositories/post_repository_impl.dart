import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/domain/repositories/posts_repository.dart';
import 'package:chambeape/infrastructure/datasources/postsdb_datasource.dart';

class PostRepositoryImpl extends PostsRepository {
  @override
  Future<List<Post>> getPosts() async {
    try {
      final datasource = PostsdbDatasource();
      return await datasource.getPosts();
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }
}

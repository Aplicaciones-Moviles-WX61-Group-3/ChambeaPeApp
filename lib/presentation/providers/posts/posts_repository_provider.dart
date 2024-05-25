import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/infrastructure/repositories/post_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsRepositoryProvider = FutureProvider<List<Post>>((ref) async {
  final repository = PostRepositoryImpl();
  return repository.getPosts();
});
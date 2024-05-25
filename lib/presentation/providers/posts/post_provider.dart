import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/infrastructure/repositories/post_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, List<Post>>((ref) {
  final repository = PostRepositoryImpl();
  return PostsNotifier(repository);
});

class PostsNotifier extends StateNotifier<List<Post>> {
  final PostRepositoryImpl repository;

  bool isLoading = false;

  PostsNotifier(this.repository) : super([]);

  Future<void> getPosts() async {
    if (isLoading) return;

    isLoading = true;
    final posts = await repository.getPosts();
    state = posts;

    isLoading = false;
  }
}

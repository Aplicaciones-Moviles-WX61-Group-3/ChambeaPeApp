import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/presentation/providers/posts/posts_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, List<Post>>((ref) {
  final repository = ref.watch(postsRepositoryProvider).getPosts;

  return PostsNotifier(
    fetchPosts: repository,
  );
});

typedef PostsCallback = Future<List<Post>> Function();

class PostsNotifier extends StateNotifier<List<Post>> {
  bool isLoading = false;

  PostsCallback fetchPosts;

  PostsNotifier({
    required this.fetchPosts,
  }) : super([]);

  Future<void> getPosts() async {
    if (isLoading) return;

    isLoading = true;
    final posts = await fetchPosts();
    state = posts;

    isLoading = false;
  }
}

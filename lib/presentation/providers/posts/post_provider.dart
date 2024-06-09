import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/presentation/providers/posts/posts_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, List<Post>>((ref) {
  final repository = ref.watch(postsRepositoryProvider);

  return PostsNotifier(
    fetchPosts: repository.getPosts,
    createPostCallback: repository.createPost,
    updatePostCallback: repository.updatePost,
    deletePostCallback: repository.deletePost,
  );
});

typedef GetPostsCallback = Future<List<Post>> Function();
typedef CreatePostCallback = Future<Post> Function(Post post);
typedef UpdatePostCallback = Future<Post> Function(Post post);
typedef DeletePostCallback = Future<void> Function(String id);

class PostsNotifier extends StateNotifier<List<Post>> {
  bool isLoading = false;
  bool _isDeleting = false;

  final GetPostsCallback fetchPosts;
  final CreatePostCallback createPostCallback;
  final UpdatePostCallback updatePostCallback;
  final DeletePostCallback deletePostCallback;

  PostsNotifier({
    required this.fetchPosts,
    required this.createPostCallback,
    required this.updatePostCallback,
    required this.deletePostCallback,
  }) : super([]);

  bool get isDeleting => _isDeleting;

  Future<void> getPosts() async {
    if (isLoading) return;

    isLoading = true;
    final posts = await fetchPosts();
    state = posts;
    isLoading = false;
  }

  Future<void> createPost(Post post) async {
    if (isLoading) return;

    isLoading = true;
    final newPost = await createPostCallback(post);
    state = [...state, newPost];
    isLoading = false;
  }
  
  Future<void> updatePost(Post post) async {
    if (isLoading) return;

    isLoading = true;
    try {
      final updatedPost = await updatePostCallback(post);
      state = state.map((p) => p.id == updatedPost.id ? updatedPost : p).toList();
    } finally {
      isLoading = false;
    }
  }

  Future<void> deletePost(String id) async {
    //TODO: Fix delete post - Loaders por cada post
    if (_isDeleting) return;

    _isDeleting = true;
    state = [...state];
    await deletePostCallback(id);
    state = state.where((p) => p.id != int.parse(id)).toList();
    _isDeleting = false;
    state = [...state];
  }
}

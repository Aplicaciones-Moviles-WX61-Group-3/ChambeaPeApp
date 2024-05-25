import 'package:chambeape/presentation/providers/posts/post_provider.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/post_card_widget2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PostView extends StatelessWidget {

  static const String routeName = 'post_view';

  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: const _PostView(),
    );
  }
}

class _PostView extends ConsumerStatefulWidget {
  const _PostView();

  @override
  createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<_PostView> {


  @override
  void initState() {
    super.initState();
    ref.read(postsProvider.notifier).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    return PostCardWidget2(posts: posts);
  }
}
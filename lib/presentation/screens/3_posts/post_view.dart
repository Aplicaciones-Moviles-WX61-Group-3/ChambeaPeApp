import 'package:chambeape/config/utils/login_user_data.dart';
import 'package:chambeape/infrastructure/models/login/login_response.dart';
import 'package:chambeape/presentation/providers/posts/post_provider.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/post_card_widget2.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/stepper_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostView extends ConsumerStatefulWidget {
  static const String routeName = 'post_view';

  const PostView({super.key});

  @override
  createState() => _PostViewState();
}

class _PostViewState extends ConsumerState<PostView> {
  LoginResponse user = LoginData().user;

  @override
  void initState() {
    super.initState();
    ref.read(postsProvider.notifier).getPosts();
    LoginData().loadSession().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StepperPost()));
            },
          ),
        ],
      ),
      body: PostCardWidget2(posts: posts),
    );
  }
}

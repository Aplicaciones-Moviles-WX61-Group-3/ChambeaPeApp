import 'package:flutter/material.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  static const String routeName = 'posts_test_view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Posts'),
      ),
    );
  }
}
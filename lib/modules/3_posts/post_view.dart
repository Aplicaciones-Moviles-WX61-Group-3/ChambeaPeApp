import 'package:chambeape/model/Post.dart';
import 'package:chambeape/modules/3_posts/post_card_widget.dart';
import 'package:chambeape/modules/3_posts/post_creation_widget.dart';
import 'package:chambeape/services/posts/post_service.dart';
import 'package:flutter/material.dart';

class PostViewWidget extends StatefulWidget {
  const PostViewWidget({super.key});

  static const String routeName = 'post_view';

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = PostService().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.add_circle_rounded,
                  color: Colors.orange,
                ),
                iconSize: 30,
                onPressed: () async {
                  Post? newPost = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostCreationWidget(),
                    ),
                  );

                  if (newPost != null) {
                    setState(() {
                      posts = PostService().getPosts();
                    });
                  }
                }),
          ],
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        PostCardWidget(postSnapshot: snapshot),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
              }
              return const Text('Aún no has creado ningún post.');
            },
          ),
        ));
  }
}

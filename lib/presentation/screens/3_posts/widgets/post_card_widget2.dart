import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:flutter/material.dart';

class PostCardWidget2 extends StatefulWidget {
  final List<Post> posts;

  const PostCardWidget2({super.key, required this.posts});

  @override
  State<PostCardWidget2> createState() => _PostCardWidget2State();
}

class _PostCardWidget2State extends State<PostCardWidget2> {


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        final post = widget.posts[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.amber.shade700.withOpacity(0.35),
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(post.imgUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        post.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            post.title,
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

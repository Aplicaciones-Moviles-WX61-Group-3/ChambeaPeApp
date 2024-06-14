import 'package:flutter/material.dart';
import 'package:chambeape/domain/entities/posts_entity.dart';

class PostCardDealWidget extends StatefulWidget {
  const PostCardDealWidget({super.key});

  @override
  State<PostCardDealWidget> createState() => _PostCardDealWidgetState();
}

class _PostCardDealWidgetState extends State<PostCardDealWidget> {
  @override
  Widget build(BuildContext context) {
    final post = Post(
      id: 1,
      title: 'Post 2',
      description: 'Description 1',
      imgUrl: 'https://via.placeholder.com/150',
      subtitle: '',
    );
    final textTheme = Theme.of(context).textTheme;
    return _PostCard(
      post: post,
      textTheme: textTheme,
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.textTheme,
  });

  final Post post;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.amber.shade700.withOpacity(0.35),
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Stack(
        children: [
          Padding(
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                          _PostButton(
                            onPressed: () {},
                            text: 'Ver Publicación',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  final buttonStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.resolveWith(
      (states) => const Size(110, 30),
    ),
  );

  _PostButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

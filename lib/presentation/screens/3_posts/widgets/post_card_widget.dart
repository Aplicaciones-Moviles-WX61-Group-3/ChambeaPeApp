import 'package:chambeape/config/utils/login_user_data.dart';
import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/infrastructure/models/login/login_response.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/stepper_post.dart';
import 'package:flutter/material.dart';

class PostCardWidget extends StatefulWidget {
  final List<Post> posts;

  const PostCardWidget({super.key, required this.posts});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  LoginResponse user = LoginData().user;

  @override
  void initState() {
    super.initState();
    LoginData().loadSession().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final role = user.userRole;

    if (widget.posts.isEmpty) {
      return Center(
        child: Text(
          'No existen Posts registrados',
          style: textTheme.bodyMedium,
        ),
      );
    } else {
      return widget.posts.isNotEmpty
          ? ListView.builder(
              itemCount: widget.posts.length,
              itemBuilder: (context, index) {
                final post = widget.posts[index];
                return _PostCard(
                  post: post,
                  textTheme: textTheme,
                  role: role,
                  onDelete: () => _showDeleteConfirmationDialog(context, post),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, Post post) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar esta publicación?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // TODO Lógica para eliminar la publicación
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.post,
    required this.textTheme,
    required this.role,
    required this.onDelete,
  });

  final Post post;
  final TextTheme textTheme;
  final String role;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
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
            role == 'E'
                ? Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StepperPost(post: post),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
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
  ));

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

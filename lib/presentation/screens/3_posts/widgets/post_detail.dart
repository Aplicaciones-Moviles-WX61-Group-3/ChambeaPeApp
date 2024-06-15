import 'package:flutter/material.dart';
import 'package:chambeape/domain/entities/posts_entity.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  final String role;

  const PostDetailPage({super.key, required this.post, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descripción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.network(
                post.imgUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (role == 'E') ...[
              const Text(
                'Chambeadores:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'No hay postulantes',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ] else if (role == 'W') ...[
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Postular'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

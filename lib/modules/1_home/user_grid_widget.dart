import 'package:flutter/material.dart';

class UserGridWidget extends StatelessWidget {
  final int crossAxisCount;
  final List<String> imageUrls;
  final String title;

  const UserGridWidget({
    Key? key,
    required this.crossAxisCount,
    required this.imageUrls,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
              vertical: 10.0), // Agrega margen arriba y abajo
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: imageUrls.map((imageUrl) {
            return AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:chambeape/model/Post.dart';
import 'package:flutter/material.dart';

class PostCardWidget extends StatefulWidget {
  final AsyncSnapshot<List<Post>> postSnapshot;
  const PostCardWidget({required this.postSnapshot,super.key});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.postSnapshot.data!.map((post) => Column(
          children: [
            Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            width: double.infinity,
            height: 155,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.shade600.withOpacity(0.35),
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(post.imgUrl),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              post.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Text(
                            post.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTheme(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.amber.shade600,
                                    minimumSize: const Size(120, 10),
                                  ),
                                  child: const Text(
                                    'Ver Publicación',
                                  ),
                                ),
                              ),
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
              ],
            ),
          ).toList(),
    );
  }
}
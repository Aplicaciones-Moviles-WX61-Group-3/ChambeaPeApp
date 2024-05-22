import 'package:chambeape/model/Post.dart';
import 'package:flutter/material.dart';
import "package:chambeape/modules/3_posts/dialog_confirmation_widget.dart";
import 'package:chambeape/modules/3_posts/post_edit_widget.dart';
import 'package:chambeape/services/posts/post_service.dart';

class PostCardWidget extends StatefulWidget {
  final AsyncSnapshot<List<Post>> postSnapshot;
  const PostCardWidget({required this.postSnapshot, super.key});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.postSnapshot.data!
          .map(
            (post) => Column(
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ButtonTheme(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                Colors.amber.shade600,
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
                          //Contendra dos iconos cicles uno para editar y otro para eliminar que estaran en la misma columna
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.amber,
                                  ),
                                  onPressed: () async {
                                    Post? updatedPost = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PostEditWidget(postRecived: post),
                                      ),
                                    );

                                    if (updatedPost != null) {
                                      setState(() {
                                        int index = widget.postSnapshot.data!
                                            .indexWhere((element) =>
                                                element.id == updatedPost.id);
                                        if (index != -1) {
                                          widget.postSnapshot.data![index] =
                                              updatedPost;
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                              Center(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.amber,
                                  ),
                                  onPressed: () {
                                    String titleDialog =
                                        "Confirmar eliminación";
                                    String messageDialog =
                                        "¿Estás seguro de eliminar este post?";
                                    String postTitle = "${post.title}";

                                    showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogConfirmationDialogWidget(
                                          title: titleDialog,
                                          content: messageDialog,
                                          postTitle: postTitle,
                                        );
                                      },
                                    ).then((value) {
                                      if (value == true) {
                                        deletePost(post.id.toString());
                                        setState(() {
                                          widget.postSnapshot.data!.removeWhere(
                                              (element) =>
                                                  element.id == post.id);
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
          .toList(),
    );
  }

  void deletePost(String id) async {
    try {
      await PostService().deletePost(id);
      print('Post eliminado con éxito');
    } catch (e) {
      print('Error al eliminar el post: $e');
    }
  }
}

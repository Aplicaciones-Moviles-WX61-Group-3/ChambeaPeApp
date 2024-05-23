import 'package:flutter/material.dart';

class DialogConfirmationDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String postTitle;

  const DialogConfirmationDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.postTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(title),
      ),
      content: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 15,
              ),
              //Centrar el texto
              Center(
                child: Text(
                  postTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Eliminar'),
        ),
      ],
    );
  }
}

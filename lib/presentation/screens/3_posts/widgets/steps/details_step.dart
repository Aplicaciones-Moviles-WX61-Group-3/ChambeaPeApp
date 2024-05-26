import 'dart:io';

import 'package:chambeape/presentation/providers/posts/steps/step_provider.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/stepper_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DetailsStepWidget extends ConsumerStatefulWidget {
  final bool hasPost;
  final StepperPost widget;

  const DetailsStepWidget({
    super.key,
    required this.hasPost,
    required this.widget,
  });

  @override
  createState() => _DetailsStepWidgetState();
}

class _DetailsStepWidgetState extends ConsumerState<DetailsStepWidget> {
  File? selectedImage;

  Future<File?> getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final stepperPost =
        ref.watch(stepperPostProvider.notifier); // Obtener el StateNotifier

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: stepperPost.formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              initialValue: widget.hasPost ? widget.widget.post?.title : '',
              validator: (String? value) {
                if (value == '' || value == null) {
                  return 'Por favor, ingrese un título';
                }
                return null;
              },
              onChanged: (value) {
                stepperPost.setTitle(value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              initialValue:
                  widget.hasPost ? widget.widget.post?.description : '',
              validator: (String? value) {
                if (value == '' || value == null) {
                  return 'Por favor, ingrese una descripción';
                }
                return null;
              },
              onChanged: (value) {
                stepperPost.setDescription(value);
              },
            ),
            const SizedBox(height: 16),
            // Campo para elegir imagen del dispositivo
            Column(
              children: [
                if (selectedImage != null)
                  SizedBox(
                    height: 200,
                    child: Image.file(selectedImage!),
                  ),
                _ImagePickerWidget(
                  onTap: () async {
                    final image = await getImage();
                    if (image != null) {
                      stepperPost.setImage(image);
                      setState(() {
                        selectedImage = image;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            widget.hasPost ? _PrevImage(widget: widget) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerWidget extends StatelessWidget {
  final VoidCallback onTap;

  const _ImagePickerWidget({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.add_circle),
              SizedBox(width: 8),
              Text("Seleccionar imagen"),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrevImage extends StatelessWidget {
  const _PrevImage({
    required this.widget,
  });

  final DetailsStepWidget widget;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        Text('Imagen Actual', style: text.bodyMedium),
        const SizedBox(height: 16),
        Image.network(widget.widget.post!.imgUrl),
      ],
    );
  }
}

import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:flutter/material.dart';

class StepperPost extends StatefulWidget {
  final Post? post; // Hacer el parámetro post opcional

  const StepperPost({super.key, this.post});

  @override
  State<StepperPost> createState() => _StepperPostState();
}

class _StepperPostState extends State<StepperPost> {
  bool hasPost = false;

  @override
  void initState() {
    super.initState();
    hasPost = widget.post != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hasPost ? 'Edit Post' : 'Create Post'),
      ),
      body: Stepper(
        currentStep: 0,
        steps: [
          Step(
            title: const Text('Step 1'),
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  initialValue: hasPost ? widget.post!.title : '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  initialValue: hasPost ? widget.post!.description : '',
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Step 2'),
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  initialValue: hasPost ? widget.post!.imgUrl : '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

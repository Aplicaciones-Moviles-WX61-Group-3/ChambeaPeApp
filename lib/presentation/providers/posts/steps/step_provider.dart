import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stepperPostProvider = StateNotifierProvider<StepperPostNotifier, TextEditingController>((ref) {
  return StepperPostNotifier();
});

class StepperPostNotifier extends StateNotifier<TextEditingController> {
  
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? selectedImage;

  GlobalKey<FormState> formKeyPost = GlobalKey<FormState>();

  StepperPostNotifier() : super(TextEditingController());

  void setTitle(String title) {
    titleController.text = title;
  }

  void setDescription(String description) {
    descriptionController.text = description;
  }

  void setImage(File image) {
    selectedImage = image;
  }

  void clear() {
    titleController.clear();
    descriptionController.clear();
    selectedImage = null;
  }

  //Get para el key del formulario
  GlobalKey<FormState> get formKey => formKeyPost;
  // getAll
  Map<String, dynamic> getAll() {
    return {
      'title': titleController.text,
      'description': descriptionController.text,
      'image': selectedImage,
    };
  }
}
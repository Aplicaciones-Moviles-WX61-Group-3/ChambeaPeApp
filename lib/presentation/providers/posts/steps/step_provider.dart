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

  TextEditingController categoryController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool hasNotification = false;

  int hasPremium = 0;
  

  GlobalKey<FormState> formKeyPostDetails = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPostLocation = GlobalKey<FormState>();

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

  void setCategory(String category) {
    categoryController.text = category;
  }

  void setLocation(String location) {
    locationController.text = location;
  }

  void setNotification(bool notification) {
    hasNotification = notification;
  }

  void setPremium(bool premium) {
    hasPremium = premium ? 1 : 0;
  }

  void clear() {
    titleController.clear();
    descriptionController.clear();
    categoryController.clear();
    locationController.clear();
    selectedImage = null;
    hasNotification = false;
    hasPremium = 0;
  }

  GlobalKey<FormState> get formKeyDetails => formKeyPostDetails;
  GlobalKey<FormState> get formKeyLocation => formKeyPostLocation;

   Map<String, dynamic> getAll() {
    return {
      'title': titleController.text,
      'description': descriptionController.text,
      'category': categoryController.text,
      'location': locationController.text,
      'image': selectedImage,
      'notification': hasNotification,
      'premium': hasPremium,
    };
  }
}

import 'dart:io';
import 'package:chambeape/presentation/providers/posts/steps/stepper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stepperPostProvider = StateNotifierProvider<StepperPostNotifier, StepperPostState>((ref) {
  return StepperPostNotifier();
});


class StepperPostNotifier extends StateNotifier<StepperPostState> {
  StepperPostNotifier()
      : super(StepperPostState(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
          categoryController: TextEditingController(),
          locationController: TextEditingController(),
          formKeyPostDetails: GlobalKey<FormState>(),
          formKeyPostLocation: GlobalKey<FormState>(),
        ));

  void setTitle(String title) {
    state.titleController.text = title;
    state = state.copyWith();
  }

  void setDescription(String description) {
    state.descriptionController.text = description;
    state = state.copyWith();
  }

  void setImage(File image) {
    state = state.copyWith(selectedImage: image);
  }

  void setCategory(String category) {
    state.categoryController.text = category;
    state = state.copyWith();
  }

  void setLocation(String location) {
    state.locationController.text = location;
    state = state.copyWith();
  }

  void setNotification(bool notification) {
    state = state.copyWith(hasNotification: notification);
  }

  void setPremium(bool premium) {
    state = state.copyWith(hasPremium: premium ? 1 : 0);
  }

  void clear() {
    state.titleController.clear();
    state.descriptionController.clear();
    state.categoryController.clear();
    state.locationController.clear();
    state = state.copyWith(selectedImage: null, hasNotification: false, hasPremium: 0);
  }

  Map<String, dynamic> getAll() {
    return {
      'title': state.titleController.text,
      'description': state.descriptionController.text,
      'category': state.categoryController.text,
      'location': state.locationController.text,
      'image': state.selectedImage,
      'notificationsEnabled': state.hasNotification,
      'hasPremium': state.hasPremium,
    };
  }
}

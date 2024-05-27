import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stepperPostProvider = StateNotifierProvider<StepperPostNotifier, StepperPostState>((ref) {
  return StepperPostNotifier();
});

class StepperPostState {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  final TextEditingController locationController;
  final bool hasNotification;
  final int hasPremium;
  final File? selectedImage;
  final GlobalKey<FormState> formKeyPostDetails;
  final GlobalKey<FormState> formKeyPostLocation;

  StepperPostState({
    required this.titleController,
    required this.descriptionController,
    required this.categoryController,
    required this.locationController,
    this.hasNotification = false,
    this.hasPremium = 0,
    this.selectedImage,
    required this.formKeyPostDetails,
    required this.formKeyPostLocation,
  });

  StepperPostState copyWith({
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    TextEditingController? categoryController,
    TextEditingController? locationController,
    bool? hasNotification,
    int? hasPremium,
    File? selectedImage,
    GlobalKey<FormState>? formKeyPostDetails,
    GlobalKey<FormState>? formKeyPostLocation,
  }) {
    return StepperPostState(
      titleController: titleController ?? this.titleController,
      descriptionController: descriptionController ?? this.descriptionController,
      categoryController: categoryController ?? this.categoryController,
      locationController: locationController ?? this.locationController,
      hasNotification: hasNotification ?? this.hasNotification,
      hasPremium: hasPremium ?? this.hasPremium,
      selectedImage: selectedImage ?? this.selectedImage,
      formKeyPostDetails: formKeyPostDetails ?? this.formKeyPostDetails,
      formKeyPostLocation: formKeyPostLocation ?? this.formKeyPostLocation,
    );
  }
}

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
  }

  void setDescription(String description) {
    state.descriptionController.text = description;
  }

  void setImage(File image) {
    state = state.copyWith(selectedImage: image);
  }

  void setCategory(String category) {
    state.categoryController.text = category;
  }

  void setLocation(String location) {
    state.locationController.text = location;
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

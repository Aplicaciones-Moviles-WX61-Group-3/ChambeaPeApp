import 'dart:io';

import 'package:chambeape/model/Post.dart';
import 'package:chambeape/services/posts/post_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
String dropdownCurrValue = 'Jardinería';
//TEMPORAL
final TextEditingController imgUrlController = TextEditingController();

class PostCreationWidget extends StatefulWidget {
  const PostCreationWidget({super.key});

  static const String routeName = 'post_creation_widget';

  @override
  State<PostCreationWidget> createState() => _PostCreationWidgetState();
}

class _PostCreationWidgetState extends State<PostCreationWidget> {
  Future<Post?>? post;
  int currStep = 0;
  final int totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
          child: Stepper(
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: currStep == totalSteps - 1
                          ? createPost()
                          : details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      child: currStep == totalSteps - 1
                          ? const Text("Publicar")
                          : const Text("Siguiente")),
                  // ElevatedButton(
                  //   onPressed: details.onStepCancel,
                  //   child: const Text("GO BACK"))
                ],
              );
            },
            connectorThickness: 3,
            onStepTapped: (int index) {
              setState(() {
                currStep = index;
              });
            },
            currentStep: currStep,
            steps: [
              Step(
                  isActive: currStep >= 0,
                  title: const SizedBox(width: 0),
                  content: const DetailsStepWidget(),
                  state: switchStepState(0)),
              Step(
                  isActive: currStep >= 1,
                  title: const SizedBox(width: 0),
                  content: const LocationStepWidget(),
                  state: switchStepState(1)),
              Step(
                  isActive: currStep >= 2,
                  title: const SizedBox(width: 0),
                  content: const SettingsStepWidget(),
                  state: switchStepState(2)),
              Step(
                  isActive: currStep >= 3,
                  title: const SizedBox(width: 0),
                  content: const ConfirmStepWidget(),
                  state: switchStepState(3))
            ],
            type: StepperType.horizontal,
            onStepContinue: () {
              switchStep(1);
            },
            onStepCancel: () {
              switchStep(-1);
            },
          )),
    );
  }

  void switchStep(int step) {
    int temp = currStep;
    temp += step;

    if (temp < 0 || temp > totalSteps - 1) {
      return;
    }

    setState(() {
      currStep = temp;
    });
  }

  StepState switchStepState(int step) {
    if (currStep > step) {
      return StepState.complete;
    } else if (currStep < step) {
      return StepState.disabled;
    } else {
      return StepState.editing;
    }
  }

  createPost() {
    final PostService postService = PostService();
    post = postService.createPost(titleController.text,
        descriptionController.text, dropdownCurrValue, imgUrlController.text);
  }
}

class DetailsStepWidget extends StatefulWidget {
  const DetailsStepWidget({super.key});

  @override
  State<DetailsStepWidget> createState() => _DetailsStepWidgetState();
}

class _DetailsStepWidgetState extends State<DetailsStepWidget> {
  final TextEditingController retributionController = TextEditingController();

  File? selectedImage;
  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      } else {
        const Text("Selecciona una imagen");
      }
    });
  }

  List<String> dropdownItems = [
    'Jardinería',
    'Educación',
    'Música',
    'Reparación de electrodomésticos',
    'Fontanería',
    'Carpintería',
    'Limpieza doméstica',
    'Pintura',
    'Diseño gráfico',
    'Consultoría financiera',
    'Traducción e interpretación',
    'Fotografía',
    'Entrenamiento personal',
    'Masajes terapéuticos',
    'Cuidado de mascotas',
    'Coaching',
    'Cocina',
    'Otro',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Detalles de la publicación",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Titulo',
              contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: DropdownButtonFormField(
              hint: const Text('Selecciona una categoría'),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 36,
              value: dropdownCurrValue,
              isExpanded: true,
              menuMaxHeight: 300,
              items: dropdownItems.map((dropdownItem) {
                return DropdownMenuItem(
                    value: dropdownItem, child: Text(dropdownItem));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownCurrValue = value!;
                });
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),                  
                  ),
            ),
          ),
          TextField(
            controller: descriptionController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              labelText: 'Descripción',              
              contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: retributionController,
            decoration: const InputDecoration(
              labelText: 'Remuneración',
              prefix: Text("S/ "),
              contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5)
              ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  selectedImage != null
                      ? Image.file(selectedImage!)
                      : const Text("Por favor, selecciona una imagen"),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        getImage();
                      });
                    },
                    icon: const Icon(Icons.add_circle),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: imgUrlController,
            decoration: const InputDecoration(
              labelText: 'URL de la imagen',
              contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class LocationStepWidget extends StatefulWidget {
  const LocationStepWidget({super.key});

  @override
  State<LocationStepWidget> createState() => _LocationStepWidgetState();
}

class _LocationStepWidgetState extends State<LocationStepWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Step 2")],
      ),
    );
  }
}

class SettingsStepWidget extends StatefulWidget {
  const SettingsStepWidget({super.key});

  @override
  State<SettingsStepWidget> createState() => _SettingsStepWidgetState();
}

class _SettingsStepWidgetState extends State<SettingsStepWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Step 3")],
      ),
    );
  }
}

class ConfirmStepWidget extends StatefulWidget {
  const ConfirmStepWidget({super.key});

  @override
  State<ConfirmStepWidget> createState() => _ConfirmStepWidgetState();
}

class _ConfirmStepWidgetState extends State<ConfirmStepWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Step 4")],
      ),
    );
  }
}

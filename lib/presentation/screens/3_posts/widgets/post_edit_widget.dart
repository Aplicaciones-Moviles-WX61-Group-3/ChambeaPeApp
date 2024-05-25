import 'dart:io';

import 'package:chambeape/infrastructure/models/post_model.dart';
import 'package:chambeape/services/posts/post_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PostModel? post;

//Step 1
final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
String dropdownCurrValue = 'Jardinería';
final TextEditingController retributionController = TextEditingController();
//Temp
final TextEditingController imgUrlController = TextEditingController();

//Step 2
final TextEditingController locationController = TextEditingController();
String dropdownDeparmentCurrVal = 'Departamento';

//Step 3
bool highlightPost = false;
bool onlySameCityWorkers = true;
bool notifyMessages = true;

class PostEditWidget extends StatefulWidget {
  final PostModel postRecived;

  const PostEditWidget({required this.postRecived, super.key});

  static const String routeName = 'post_edit_widget';

  @override
  State<PostEditWidget> createState() => _PostEditWidgetState();
}

class _PostEditWidgetState extends State<PostEditWidget> {
  bool isLoading = false;

  int currStep = 0;
  final int totalSteps = 4;

  @override
  void initState() {
    super.initState();

    post = PostModel(
      id: widget.postRecived.id,
      title: widget.postRecived.title,
      description: widget.postRecived.description,
      subtitle: widget.postRecived.subtitle,
      imgUrl: widget.postRecived.imgUrl,
    );

    print("Post received");
    print(post!.toJson());

    titleController.text = post!.title;
    descriptionController.text = post!.description;
    dropdownCurrValue = post!.subtitle;
    imgUrlController.text = post!.imgUrl;
  }

  void handleEditPost() async {
    PostModel? updatedPost = await editPost();
    Navigator.pop(context, updatedPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
          child: Stepper(
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: currStep == totalSteps - 1
                          ? () => handleEditPost()
                          : details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 50),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      child: currStep == totalSteps - 1
                          ? const Text("Actualizar")
                          : const Text("Siguiente")),
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
                  content: DetailsStepWidget(),
                  state: switchStepState(0)),
              Step(
                  isActive: currStep >= 1,
                  title: const SizedBox(width: 0),
                  content: LocationStepWidget(),
                  state: switchStepState(1)),
              Step(
                  isActive: currStep >= 2,
                  title: const SizedBox(width: 0),
                  content: SettingsStepWidget(),
                  state: switchStepState(2)),
              Step(
                  isActive: currStep >= 3,
                  title: const SizedBox(width: 0),
                  content: ConfirmStepWidget(),
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

  Future<PostModel?> editPost() async {
    setState(() {
      isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final PostService postService = PostService();

      PostModel postEdited = PostModel(
          id: post!.id,
          title: titleController.text,
          description: descriptionController.text,
          subtitle: dropdownCurrValue,
          imgUrl: imgUrlController.text);

      postEdited = await postService.updatePost(
          postEdited.id.toString(),
          postEdited.title,
          postEdited.description,
          postEdited.subtitle,
          postEdited.imgUrl);

      Navigator.pop(context);

      return postEdited;
    } catch (e) {
      Navigator.pop(context);
      print('Error updating post: $e');
      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

class DetailsStepWidget extends StatefulWidget {
  const DetailsStepWidget({super.key});

  @override
  State<DetailsStepWidget> createState() => _DetailsStepWidgetState();
}

class _DetailsStepWidgetState extends State<DetailsStepWidget> {
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
              dropdownColor: Colors.white,
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5)),
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
  List<String> dropdownDepartments = [
    'Departamento',
    'Lima',
    'Ancash',
    'Apurimac',
    'Arequipa',
    'Ayacucho',
    'Cajamarca',
    'Callao',
    'Cusco',
    'Huancavelica',
    'Huanuco',
    'Ica',
    'Junin',
    'La Libertad',
    'Lambayeque',
    'Lima Region',
    'Loreto',
    'Madre de Dios',
    'Moquegua',
    'Pasco',
    'Piura',
    'Puno',
    'San Martin',
    'Tacna',
    'Tumbes',
    'Ucayali',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Ubicación del trabajo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: DropdownButtonFormField(
              hint: const Text('Selecciona un departamento'),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 36,
              value: dropdownDeparmentCurrVal,
              isExpanded: true,
              menuMaxHeight: 300,
              dropdownColor: Colors.white,
              items: dropdownDepartments.map((dropdownItem) {
                return DropdownMenuItem(
                    value: dropdownItem, child: Text(dropdownItem));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownDeparmentCurrVal = value!;
                });
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
            ),
          ),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(
              labelText: 'Dirección',
              contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Configura tu publicación",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Destacar anuncio", style: TextStyle(fontSize: 16)),
              const SizedBox(
                width: 10,
              ),
              Switch(
                value: highlightPost,
                activeColor: Colors.amber.shade700,
                onChanged: (bool value) {
                  setState(() {
                    highlightPost = value;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Notificar mensajes",
                style: TextStyle(
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 10,
              ),
              Switch(
                value: notifyMessages,
                activeColor: Colors.amber.shade700,
                onChanged: (bool value) {
                  setState(() {
                    notifyMessages = value;
                  });
                },
              ),
            ],
          )
        ],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Confirmar publicación",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Título",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(titleController.text, style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Categoría",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(dropdownCurrValue, style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Remuneración",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text('S/ ${retributionController.text}',
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Departamento",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(dropdownDeparmentCurrVal,
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dirección",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(locationController.text,
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Destacar anuncio",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(highlightPost ? "Sí" : "No",
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Notificar mensajes",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 10,
              ),
              Text(notifyMessages ? "Sí" : "No",
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

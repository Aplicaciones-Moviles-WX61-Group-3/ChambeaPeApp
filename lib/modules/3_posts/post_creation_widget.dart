import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostCreationWidget extends StatefulWidget {
  const PostCreationWidget({super.key});

  @override
  State<PostCreationWidget> createState() => _PostCreationWidgetState();
}

class _PostCreationWidgetState extends State<PostCreationWidget> {
  int currStep = 0;
  final int totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
        child:   Theme(data: ThemeData(
                  canvasColor: Colors.white,
                  primarySwatch: Colors.orange,
                  colorScheme: const ColorScheme.light(
                  primary: Colors.orange,
                  secondary: Colors.orange,
                  background: Colors.grey
                  )
                ), child: Stepper(
                    controlsBuilder:(context, details) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade700,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(300, 50),
                              textStyle: const TextStyle(          
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                            child: const Text("Siguiente")
                            ),
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
                        content: DetailsStepWidget(),
                        state: switchStepState(0)
                        ),
                      Step(
                        isActive: currStep >= 1,
                        title: const SizedBox(width: 0),
                        content: LocationStepWidget(),
                        state: switchStepState(1)
                      ),
                      Step(
                        isActive: currStep >= 2,
                        title: const SizedBox(width: 0),
                        content: SettingsStepWidget(),
                        state: switchStepState(2)
                      ),
                      Step(
                        isActive: currStep >= 3,
                        title: const SizedBox(width: 0),
                        content: ConfirmStepWidget(),
                        state: switchStepState(3)
                      )
                    ],
                    type: StepperType.horizontal,
                    onStepContinue: (){
                        switchStep(1);
                    },
                    onStepCancel: (){
                        switchStep(-1);
                    },
                  )),
    ));
  }

  void switchStep(int step){
    int temp = currStep;
    temp += step;
    
    if(temp < 0 || temp > totalSteps-1){
      return;
    }

    setState(() {
      currStep = temp;
    }); 
  }

  StepState switchStepState(int step){
    if(currStep > step){
      return StepState.complete;
    }
    else if(currStep < step){
      return StepState.disabled;
    }
    else{
      return StepState.editing;
    }
  }
}

class DetailsStepWidget extends StatefulWidget {
  const DetailsStepWidget({super.key});

  @override
  State<DetailsStepWidget> createState() => _DetailsStepWidgetState();
}

class _DetailsStepWidgetState extends State<DetailsStepWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController retributionController = TextEditingController();
  String dropdownCurrValue = 'Jardinería';

  File? selectedImage;
  Future getImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

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
            const Text("Detalles de la publicación", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10,),
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Titulo',
                labelStyle: const TextStyle(color: Colors.black),
                contentPadding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                border: const OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber.shade700),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber.shade700),
                ),
              ),
            ),
            const SizedBox(height: 10,),
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
                    value: dropdownItem,
                    child: Text(dropdownItem));
                }).toList(), 
                onChanged:(value) {
                  setState(() {
                    dropdownCurrValue = value!;
                  }); 
                },
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber.shade700),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber.shade700),
                  )
                ),
              ),
            ),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Descripción',
                labelStyle: const TextStyle(color: Colors.black,),
                contentPadding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                border: const OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber.shade700),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber.shade700),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: retributionController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Remuneración',
                labelStyle: const TextStyle(color: Colors.black),
                prefix: const Text("S/ "),
                contentPadding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                border: const OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber.shade700),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber.shade700),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5) 
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    selectedImage != null ? Image.file(selectedImage!) : const Text("Por favor, selecciona una imagen"),
                    IconButton(
                      onPressed:() {
                            setState(() {
                              getImage();
                            });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              
            ),
              const SizedBox(height: 100,),
              // 

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
          children: <Widget>[
            Text("Step 2")
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
    return const Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Step 3")
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
    return const Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Step 4")
          ],
        ),
      );
  }
}
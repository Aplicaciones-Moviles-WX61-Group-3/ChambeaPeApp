import 'package:flutter/material.dart';

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
                  colorScheme: const ColorScheme.dark(
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
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Detalles de la publicacion", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10,)
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
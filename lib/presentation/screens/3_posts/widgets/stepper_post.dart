import 'package:chambeape/domain/entities/posts_entity.dart';
import 'package:chambeape/presentation/providers/posts/steps/step_provider.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/steps/details_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepperPost extends ConsumerStatefulWidget {
  final Post? post;

  const StepperPost({super.key, this.post});

  @override
  createState() => _StepperPostState();
}

class _StepperPostState extends ConsumerState<StepperPost> {
  bool hasPost = false;
  int currStep = 0;

  @override
  void initState() {
    super.initState();
    hasPost = widget.post != null;
  }

  @override
  Widget build(BuildContext context) {
    final stepperPostProv = ref.watch(stepperPostProvider.notifier);

    const totalSteps = 4;
    return Scaffold(
      appBar: AppBar(
        title: Text(hasPost ? 'Editar post' : 'Crear post'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: currStep,
        onStepContinue: () async {
          // Validar el formulario antes de pasar al siguiente paso
          final form = stepperPostProv.formKey.currentState;
          if (form != null && form.validate()) {
            if (currStep < totalSteps - 1) {
              setState(() {
                currStep += 1;
              });
            } else {
              // Guardar el post
              print('Guardando post...');
              final data = stepperPostProv.getAll();
              print(data);
            }
          }
        },
        onStepCancel: () {
          if (currStep > 0) {
            setState(() {
              currStep -= 1;
            });
          }
        },
        steps: [
          Step(
            title: const SizedBox.shrink(),
            content: DetailsStepWidget(hasPost: hasPost, widget: widget),
            isActive: currStep >= 0,
          ),
          Step(
            title: const SizedBox.shrink(),
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  initialValue: hasPost ? widget.post?.imgUrl : '',
                ),
              ],
            ),
            isActive: currStep >= 1,
          ),
          // Añadir más pasos según sea necesario
          Step(
            title: const SizedBox.shrink(),
            content: const Text('Contenido del paso 3'),
            isActive: currStep >= 2,
          ),
          Step(
            title: const SizedBox.shrink(),
            content: const Text('Contenido del paso 4'),
            isActive: currStep >= 3,
          ),
        ],
        controlsBuilder: (context, details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (currStep > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Volver'),
                ),
              if (currStep < totalSteps - 1)
                TextButton(
                  onPressed: details.onStepContinue,
                  child: const Text('Siguiente'),
                ),
              if (currStep == totalSteps - 1)
                TextButton(
                  onPressed: () {
                    // Guardar el post
                    print('Guardando post...');
                    final data = stepperPostProv.getAll();
                    print(data);
                  },
                  child: const Text('Guardar'),
                ),
            ],
          );
        },
      ),
    );
  }
}

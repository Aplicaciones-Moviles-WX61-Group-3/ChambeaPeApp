import 'package:chambeape/presentation/providers/posts/steps/step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmStep extends ConsumerWidget {
  const ConfirmStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepperPostProv = ref.watch(stepperPostProvider.notifier);

    final data = stepperPostProv.getAll();

    return Column(
      children: [
        Text('Confirmar'),
        Text('Título: ${data['title']}'),
        Text('Descripción: ${data['description']}'),
        Text('Categoría: ${data['category']}'),
        Text('Ubicación: ${data['location']}'),
        Text('Notificación: ${data['notification']}'),
        Text('Premium: ${data['premium']}'),
      ],
    );
  }
}
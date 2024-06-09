import 'package:chambeape/presentation/providers/theme_provider.dart';
import 'package:chambeape/presentation/screens/0_login/login_view.dart';
import 'package:chambeape/services/login/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OptionsView extends ConsumerWidget {
  static const String routeName = 'options_view';

  const OptionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    Future<void> logout() async {
      await SessionService().logout();
      context.goNamed(LoginView.routeName);  // Usa GoRouter para la redirección
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SwitchListTile(
              title: const Text('Modo oscuro'),
              subtitle: const Text('Cambia el tema de la aplicación'),
              value: isDarkMode,
              onChanged: (bool value) {
                ref.read(themeNotifierProvider.notifier).toggleDarkMode();
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FilledButton(
                onPressed: logout, // Utiliza la función logout aquí
                child: const Text('Cerrar sesión'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
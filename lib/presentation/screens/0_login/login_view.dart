import 'package:chambeape/config/routes/app_routes.dart';
import 'package:chambeape/presentation/screens/0_login/register_view.dart';
import 'package:chambeape/presentation/shared/custom_navbar.dart';
import 'package:chambeape/services/login/login_service.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = 'login_view';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Agregar el logo de la aplicación
                Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/images/logo_white_letters.png'
                      : 'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa tu correo',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa tu contraseña',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                LoginButton(
                  text: 'Iniciar sesión',
                  onPressed: () async {
                    try {
                      await login(
                          emailController.text, passwordController.text);
                      appRouterNotLogged.replaceNamed(CustomNavbar.routeName);
                    } catch (e) {
                      // TODO Implementar la funcionalidad de mostrar un mensaje de error aquí
                    }
                  },
                ),
                const SizedBox(height: 10),
                LoginButton(
                  text: 'Registrarse',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ));
                  },
                ),
                TextButton(
                  onPressed: () {
                    // TODO Implementar la funcionalidad de recuperación de contraseña aquí
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.amber.shade700,
                  ),
                  child: const Text('¿Olvidaste tu contraseña?'),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 45,
          color: Colors.amber.shade700,
          child: Text(
            '© ${DateTime.now().year} DigitalDart Todos los derechos reservados',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const LoginButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      child: Text(text),
    );
  }
}

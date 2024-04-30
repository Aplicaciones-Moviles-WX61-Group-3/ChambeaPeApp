import 'package:chambeape/model/log_in.dart';
import 'package:chambeape/services/login/login_service.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Future<Login?>? _login;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Agregar el logo de la aplicación
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 300,  
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Ingresa tu correo',
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
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Ingresa tu contraseña',
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
              obscureText: true,
            ),
            const SizedBox(height: 10),
            LoginButton(
              text: 'Iniciar sesión',
              onPressed: () {
                setState(() {
                  _login = login(
                    emailController.text,
                    passwordController.text,
                  );
                });
              },
            ),
            const SizedBox(height: 10),
            const LoginButton(text: 'Registrarse'),
            TextButton(
              onPressed: () {
                // ! Implementar la funcionalidad de recuperación de contraseña aquí
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.amber.shade700,
              ),
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
            FutureBuilder<Login?>(
              future: _login,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } 
                else if (snapshot.hasError) {
                  return const Text('Ingrese un correo y contraseña válidos');
                } 
                else if (snapshot.hasData) {
                  return Text('Email: ${snapshot.data!.email}');
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber.shade700,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '© ${DateTime.now().year} DigitalDart Todos los derechos reservados',
            style: const TextStyle(color: Colors.white),
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

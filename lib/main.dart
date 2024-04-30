import 'package:chambeape/modules/0_login/login_view.dart';
import 'package:chambeape/modules/navigation_menu.dart';
import 'package:chambeape/services/login/session_service.dart';
import 'package:chambeape/shared/routes/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar la sesión del usuario al iniciar la aplicación
  bool hasSession = await SessionService().loadSession();

  runApp(MyApp(hasSession: hasSession));
}

class MyApp extends StatelessWidget {
  final bool hasSession;

  const MyApp({super.key, required this.hasSession});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChambeaPe',
      theme: ThemeData(
        colorSchemeSeed: Colors.amber.shade700,
      ),
      initialRoute: hasSession ? NavigationMenu.routeName : LoginView.routeName,
      routes: customRoutes,
    );
  }
}
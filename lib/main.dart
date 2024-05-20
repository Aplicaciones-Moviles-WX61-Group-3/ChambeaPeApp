import 'package:chambeape/modules/0_login/login_view.dart';
import 'package:chambeape/modules/navigation_menu.dart';
import 'package:chambeape/services/login/session_service.dart';
import 'package:chambeape/shared/routes/routes.dart';
import 'package:chambeape/shared/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool hasSession = await SessionService().loadSession();
  
  tz.initializeTimeZones();
  runApp(MyApp(hasSession: hasSession));
}

class MyApp extends StatelessWidget {
  final bool hasSession;

  const MyApp({super.key, required this.hasSession});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChambeaPe',
      theme: AppTheme.lightTheme(),
      initialRoute: hasSession ? NavigationMenu.routeName : LoginView.routeName,
      routes: customRoutes,
    );
  }
}
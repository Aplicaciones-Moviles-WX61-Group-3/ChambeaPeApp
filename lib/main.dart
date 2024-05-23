import 'package:chambeape/modules/0_login/login_view.dart';
import 'package:chambeape/modules/navigation_menu.dart';
import 'package:chambeape/presentation/providers/theme_provider.dart';
import 'package:chambeape/services/login/session_service.dart';
import 'package:chambeape/config/routes/routes.dart';
import 'package:chambeape/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool hasSession = await SessionService().loadSession();
  
  tz.initializeTimeZones();
  runApp(
    ProviderScope(
      child: MyApp(hasSession: hasSession),
    )
  );
}

class MyApp extends ConsumerWidget {
  final bool hasSession;

  const MyApp({super.key, required this.hasSession});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChambeaPe',
      theme: appTheme.getTheme(), 
      initialRoute: hasSession ? NavigationMenu.routeName : LoginView.routeName,
      routes: customRoutes,
    );
  }
}
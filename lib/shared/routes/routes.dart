import 'package:chambeape/modules/0_login/login_view.dart';
import 'package:chambeape/modules/navigation_menu.dart';
import 'package:flutter/material.dart';

var customRoutes = <String, WidgetBuilder>{
  LoginView.routeName: (context) => const LoginView(),
  NavigationMenu.routeName: (context) => const NavigationMenu(),
};
import 'package:chambeape/modules/0_login/login_view.dart';
import 'package:chambeape/modules/5_profile/profile_view.dart';
import 'package:flutter/material.dart';

var customRoutes = <String, WidgetBuilder>{
  LoginView.routeName: (context) => const LoginView(),
  ProfileView.routeName: (context) => const ProfileView(),
};
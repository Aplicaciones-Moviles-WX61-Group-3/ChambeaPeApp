import 'package:chambeape/presentation/screens/0_login/login_view.dart';
import 'package:chambeape/presentation/screens/3_posts/widgets/post_creation_widget.dart';
import 'package:chambeape/presentation/screens/3_posts/post_view.dart';
import 'package:chambeape/presentation/screens/navigation_menu.dart';
import 'package:flutter/material.dart';

var customRoutes = <String, WidgetBuilder>{
  LoginView.routeName: (context) => const LoginView(),
  PostView.routeName: (context) => const PostView(),
  PostCreationWidget.routeName: (context) => const PostCreationWidget(),
  NavigationMenu.routeName: (context) => const NavigationMenu(),
};
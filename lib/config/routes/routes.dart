import 'package:chambeape/modules/0_login/login_view.dart';
import 'package:chambeape/modules/3_posts/post_creation_widget.dart';
import 'package:chambeape/modules/3_posts/post_view.dart';
import 'package:chambeape/modules/navigation_menu.dart';
import 'package:flutter/material.dart';

var customRoutes = <String, WidgetBuilder>{
  LoginView.routeName: (context) => const LoginView(),
  PostViewWidget.routeName: (context) => const PostViewWidget(),
  PostCreationWidget.routeName: (context) => const PostCreationWidget(),
  NavigationMenu.routeName: (context) => const NavigationMenu(),
};
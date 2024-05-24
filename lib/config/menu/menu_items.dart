import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.link,
    required this.icon
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Inicio',
    link: '/',
    icon: Icons.home
  ),
  MenuItem(
    title: 'Posts',
    link: '/posts',
    icon: Icons.post_add
  ),
  MenuItem(
    title: 'Chat',
    link: '/chat',
    icon: Icons.chat
  ),
  MenuItem(
    title: 'Workers',
    link: '/workers',
    icon: Icons.work
  ),
  MenuItem(
    title: 'Perfil',
    link: '/profile',
    icon: Icons.person
  )
];
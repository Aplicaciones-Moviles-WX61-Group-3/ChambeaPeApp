import 'package:chambeape/config/menu/menu_items.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: appMenuItems.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title
        )).toList(),
      ),
    );
  }
}
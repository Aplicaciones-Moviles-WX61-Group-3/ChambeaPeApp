import 'package:chambeape/config/menu/menu_items.dart';
import 'package:chambeape/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatefulWidget {

  static const routeName = 'custom_navbar';

  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {

  int selectedIndex = 0;

  final screens = [
    const HomeView(),
    const PostView(),
    const ChatListView(),
    const WorkersView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        title: const Text('ChambeaPe'),
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset('assets/images/logo_white.png'),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: appMenuItems.map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title
        )).toList(),
      )
    );
  }
}
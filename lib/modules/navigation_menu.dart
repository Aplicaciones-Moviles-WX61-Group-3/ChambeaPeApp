import 'package:chambeape/modules/1_home/home_view.dart';
import 'package:chambeape/modules/2_workers/workers_view.dart';
// import 'package:chambeape/modules/2_workers/workers_view.dart';
import 'package:chambeape/modules/3_posts/post_creation_widget.dart';
import 'package:chambeape/modules/3_posts/post_view.dart';
import 'package:chambeape/modules/4_notifications/notifications_view.dart';
import 'package:chambeape/modules/5_profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  static const String routeName = 'navigation_menu';

  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

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
      bottomNavigationBar: Obx(() => NavigationBar(
            // Hacer que el texto del indicador seleccionado sea de color blanco
            height: 60,
            elevation: 30,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
              NavigationDestination(icon: Icon(Icons.post_add), label: 'Posts'),
              NavigationDestination(icon: Icon(Icons.add_circle), label: 'Agregar'),
              NavigationDestination(icon: Icon(Icons.work), label: 'Workers'),
            ],
          )),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeView(),
    const PostViewWidget(),
    const PostCreationWidget(),
    // const WorkersView(),
    const WorkersView(),
    // const ProfileView(),
  ];
}

import 'package:get/get.dart';
import 'package:moozic/screens/home.dart';
import 'package:moozic/screens/search.dart';
import 'package:moozic/screens/setttings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  // List of Screens for Navigation Bar
  final screens = [HomeScreen(), SearchScreen(), SettingsScreen()];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.put(
      BottomNavController(),
    );
    return Obx(
      () => CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.green.shade900,
        buttonBackgroundColor: Colors.green.shade900,
        height: 60,
        index: bottomNavController.selectedIndex.value,
        onTap: (index) => bottomNavController.changeTab(index),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.download, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}

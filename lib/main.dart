import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/bottomBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(
    BottomNavController(),
  );

  @override
  Widget build(BuildContext context) {
    // Initialize Just Audio Background

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        body: Obx(
          () => IndexedStack(
            index: bottomNavController.selectedIndex.value,
            children: bottomNavController.screens,
          ),
        ),
      ),
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/bottomBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BottomNavController bottomNavController = Get.put(
    BottomNavController(),
  );
  @override
  Widget build(BuildContext context) {
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

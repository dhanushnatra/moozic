import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/bottomBar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final BottomNavController controller = Get.put(BottomNavController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [BottomPlayer(), BottomNavBar()],
        ),
        body: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.screens,
          ),
        ),
      ),
    );
  }
}

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/bottomBar.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioService.init(
    builder: () => Audio,
    config: const AudioServiceConfig(
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationColor: 0xFF2196F3,
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: true,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/bottomBar.dart';
import 'package:moozic/components/audio_controller.dart';
import 'package:saavnapi/saavnapi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(
    BottomNavController(),
  );

  void playsong() {
    final audioController = Get.put(AudioController());
    audioController.addSongtoQueue(
      Song(
        id: "Vv39UvCz",
        title: "Samayama (From Hi Nanna)",
        imageUrl:
            "https://c.saavncdn.com/307/Samayama-From-Hi-Nanna-Telugu-2023-20230918164922-150x150.jpg",
        url:
            "https://aac.saavncdn.com/307/a3f7b8cd383c95bad0310aca20e0c2a0_160.mp4",
        duration: "204",
        language: "telugu",
        artist: "Hesham Abdul Wahab",
      ),
    );
    print("Song added to queue");
    audioController.playNext();
  }

  @override
  Widget build(BuildContext context) {
    playsong();
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

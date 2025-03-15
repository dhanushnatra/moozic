import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/bottomBar.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(
    BottomNavController(),
  );

  MyApp({super.key});
  void playmusic() async {
    // Implement your play music logic here
    final player = AudioPlayer(); // Create a player
    final duration = await player.setUrl(
      // Load a URL
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ); // Schemes: (https: | file: | asset: )
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    // Call the playmusic function to start playing music
    playmusic();
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

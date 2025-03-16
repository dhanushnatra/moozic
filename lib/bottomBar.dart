import 'package:get/get.dart';
import 'package:moozic/components/audio_controller.dart';
import 'package:moozic/screens/home.dart';
import 'package:moozic/screens/music.dart';
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
        backgroundColor: const Color.fromARGB(255, 47, 48, 47).withOpacity(0.2),
        color: Colors.green.shade900,
        buttonBackgroundColor: Colors.green.shade900,
        height: 60,
        index: bottomNavController.selectedIndex.value,
        onTap: (index) => bottomNavController.changeTab(index),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 320),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.download, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}

class BottomPlayer extends StatelessWidget {
  BottomPlayer({super.key});
  final AudioController audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          audioController.songQueue.isNotEmpty
              ? GestureDetector(
                onTap: () {
                  Get.to(
                    () => MusicScreen(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                child: Container(
                  height: 60,
                  color: const Color.fromARGB(255, 47, 48, 47).withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        final song =
                            audioController.songQueue.isNotEmpty
                                ? audioController.songQueue[audioController
                                    .currentIndex
                                    .value]
                                : null;
                        return song != null
                            ? Row(
                              children: [
                                Image.network(
                                  song.imageUrl,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  song.title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                            : const SizedBox();
                      }),
                      IconButton(
                        icon: Obx(
                          () => Icon(
                            audioController.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          audioController.playPause();
                        },
                      ),
                    ],
                  ),
                ),
              )
              : SizedBox(),
    );
  }
}

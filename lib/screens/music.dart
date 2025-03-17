import 'package:flutter/material.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:get/get.dart';
import 'package:moozic/components/audio_controller.dart';

class MusicScreen extends StatelessWidget {
  MusicScreen({super.key});
  final AudioController audioController = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    final Song song =
        audioController.songQueue[audioController.currentIndex.value];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(song.imageUrl),
            Text(song.title, style: TextStyle(fontSize: 24)),
            Text(song.artist, style: TextStyle(fontSize: 18)),
            IconButton(
              onPressed: () {
                print("Song added to queue");
                audioController.playPause();
              },

              icon: Obx(
                () => Icon(
                  audioController.isPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

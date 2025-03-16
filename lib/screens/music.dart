import 'package:flutter/material.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:get/get.dart';
import 'package:moozic/components/audio_controller.dart';

class MusicScreen extends StatelessWidget {
  MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final song =
                  audioController.songQueue.isNotEmpty
                      ? audioController.songQueue.first
                      : null;
              if (song == null) {
                return Text("No song playing");
              }
              return Column(
                children: [
                  Image.network(song.imageUrl),
                  Text(song.title, style: TextStyle(fontSize: 24)),
                  Text(song.artist, style: TextStyle(fontSize: 18)),
                ],
              );
            }),
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

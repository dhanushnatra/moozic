import 'package:flutter/material.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:get/get.dart';
import 'package:moozic/components/audio_controller.dart';

class MusicScreen extends StatelessWidget {
  final Song song;
  final AudioController audioController = Get.put(AudioController());

  MusicScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(song.imageUrl),
            Text(song.title),
            Text(song.artist),
            ElevatedButton(
              onPressed: () {
                audioController.addSongtoQueue(song);
                audioController.playPause();
                print("Song added to queue");
              },
              child: Obx(
                () => Text(
                  audioController.isPlaying.value ? "Pause" : "Play",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

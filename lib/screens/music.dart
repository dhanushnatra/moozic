import 'package:flutter/material.dart';
import 'package:moozic/components/audio_controller.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:get/get.dart';

class MusicScreen extends StatelessWidget {
  final AudioController audioController = Get.put(AudioController());
  final Song song;
  MusicScreen({required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio Player with GetX & Background")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display Track Info
            Text(
              song.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              song.artist,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            SizedBox(height: 20),

            // **Slider for Seeking**
            Obx(
              () => Column(
                children: [
                  Slider(
                    min: 0,
                    max: audioController.duration.value.inSeconds.toDouble(),
                    value: audioController.position.value.inSeconds.toDouble(),
                    onChanged: (value) {
                      audioController.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Text(
                    "${audioController.position.value.inMinutes}:${(audioController.position.value.inSeconds % 60).toString().padLeft(2, '0')} / "
                    "${audioController.duration.value.inMinutes}:${(audioController.duration.value.inSeconds % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // **Play / Pause Button**
            Obx(
              () => IconButton(
                icon: Icon(
                  audioController.isPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                iconSize: 50,
                onPressed: () {
                  if (audioController.isPlaying.value) {
                    audioController.pause();
                  } else {
                    audioController.setAudio(song);
                    audioController.play();
                  }
                },
              ),
            ),

            // **Stop Button**
            ElevatedButton(
              onPressed: () => audioController.stop(),
              child: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}

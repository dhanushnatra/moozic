import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:moozic/components/audio_controller.dart';
import 'package:saavnapi/saavnapi.dart' show Song;

class MusicScreen extends StatelessWidget {
  final Song song;
  const MusicScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.put(AudioController());
    return Scaffold(
      appBar: AppBar(title: Text(song.title)),
      body: StreamBuilder<Object>(
        stream: audioController.positionStream,
        initialData: const Duration(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Text(song.title, style: TextStyle(fontSize: 12.2)),
                Image(image: NetworkImage(song.imageUrl)),
                Obx(
                  () => IconButton(
                    icon: Icon(
                      audioController.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    iconSize: 64.0,
                    onPressed: () {
                      if (audioController.isPlaying.value) {
                        audioController.pause();
                      } else {
                        print("calling play");
                        audioController.play(song.url);
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

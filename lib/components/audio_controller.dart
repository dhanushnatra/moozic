import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  Stream<Duration> get positionStream => audioPlayer.positionStream;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.playingStream.listen((isPlaying) {
      this.isPlaying.value = isPlaying;
    });
  }

  void play(String url) async {
    await audioPlayer.setUrl(url);
    if (audioPlayer.playing) {
      audioPlayer.stop();
    }
    audioPlayer.play();
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    audioPlayer.stop();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}

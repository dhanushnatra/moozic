import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';

class AudioController extends GetxController {
  final AudioHandler audioHandler;

  var isPlaying = false.obs;

  AudioController(this.audioHandler) {
    audioHandler.playbackState.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  void play() => audioHandler.play();
  void pause() => audioHandler.pause();
  void stop() => audioHandler.stop();
  void seek(Duration position) => audioHandler.seek(position);
  void setAudio(String url) => audioHandler.setUrl(url);
}

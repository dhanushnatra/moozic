import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  var isPlaying = false.obs;
  var position = Rx<Duration>(Duration.zero);
  var duration = Rx<Duration>(Duration.zero);

  @override
  void onInit() {
    super.onInit();

    // Listen to audio position changes
    _audioPlayer.positionStream.listen((p) {
      position.value = p;
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((d) {
      if (d != null) duration.value = d;
    });

    // Listen to player state
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  Future<void> setAudio(String url, String title, String artist, String imageUrl) async {
    await _audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: url,
          title: title,
          artist: artist,
          artUri: Uri.parse(imageUrl),
        ),
      ),
    );
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}

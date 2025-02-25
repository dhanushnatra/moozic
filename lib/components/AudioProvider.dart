import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:moozic/components/audio_player.dart';

class AudioController extends GetxController {
  late MyAudioHandler _audioHandler;
  var isPlaying = false.obs;
  var currentTrackTitle = "No Track".obs;

  @override
  void onInit() {
    super.onInit();
    
  }

  Future<void> _initAudioService() async {
    _audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.music',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );
  }

  Future<void> playTrack(String url, String title) async {
    currentTrackTitle.value = title;
    await _audioHandler.playTrack(url);
    isPlaying.value = true;
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      _audioHandler.pause();
      isPlaying.value = false;
    } else {
      _audioHandler.play();
      isPlaying.value = true;
    }
  }

  void stop() {
    _audioHandler.stop();
    isPlaying.value = false;
  }
}

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _player.playerStateStream.listen((state) {
      playbackState.add(
        PlaybackState(
          controls: [MediaControl.play, MediaControl.pause, MediaControl.stop],
          playing: state.playing,
          processingState: _convertProcessingState(state.processingState,),
        ),
      );
    });
  }

  Future<void> playTrack(String url) async {
    try {
      await _player.setUrl(url);
      _player.play();
    } catch (e) {
      print("Error playing track: $e");
    }
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    playbackState.add(playbackState.value.copyWith(playing: false));
  }

  AudioProcessingState _convertProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      }
  }
}

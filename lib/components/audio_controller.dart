import 'dart:collection';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:just_audio_background/just_audio_background.dart';
part 'changer.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();

  final Queue<AudioSource> _queue = Queue<AudioSource>();
  ConcatenatingAudioSource get concatenatingAudioSource {
    return ConcatenatingAudioSource(children: _queue.toList());
  }

  void setplayerSource(Queue<AudioSource> q) {
    audioPlayer.setAudioSource(ConcatenatingAudioSource(children: q.toList()));
  }

  RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        isPlaying.value = true;
      } else {
        isPlaying.value = false;
      }
      update();
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void playNext() {
    if (_queue.isNotEmpty) {
      _queue.removeFirst();
      if (_queue.isNotEmpty) {
        audioPlayer.setAudioSource(_queue.first);
        audioPlayer.play();
      }
    }
  }

  void playPrevious() {
    if (_queue.isNotEmpty) {
      _queue.removeLast();
      if (_queue.isNotEmpty) {
        audioPlayer.setAudioSource(_queue.last);
        audioPlayer.play();
      }
    }
  }

  void playPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void stop() {
    audioPlayer.stop();
  }

  void seekToNext() {
    if (_queue.isNotEmpty) {
      audioPlayer.seekToNext();
    }
  }

  void seekToPrevious() {
    if (_queue.isNotEmpty) {
      audioPlayer.seekToPrevious();
    }
  }

  void addPlaylistToQueue(PlaylistWithSongs playlist) {
    _queue.clear();
    _queue.addAll(playlistToAudio(playlist));
    setplayerSource(_queue);
    audioPlayer.play();
  }

  void addAlbumToQueue(AlbumWithSongs album) {
    _queue.clear();
    _queue.addAll(albumToAudio(album));
    setplayerSource(_queue);
    audioPlayer.play();
  }

  void addArtistToQueue(ArtistWithSongs artist) {
    _queue.clear();
    _queue.addAll(artistToAudio(artist));
    setplayerSource(_queue);
    audioPlayer.play();
  }

  void addSongsToQueue(Songs songs) {
    _queue.addAll(songstoAudio(songs));
    setplayerSource(_queue);
    audioPlayer.play();
  }

  void addSongtoQueue(Song song) {
    _queue.add(songToAudio(song));
    setplayerSource(_queue);
    audioPlayer.play();
  }

  void removeSongFromQueue(Song song) {
    _queue.remove(songToAudio(song));
    setplayerSource(_queue);
  }

  void clearQueue() {
    _queue.clear();
    setplayerSource(_queue);
  }
}

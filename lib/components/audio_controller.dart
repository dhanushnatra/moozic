import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavnapi/saavnapi.dart';
part 'changer.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  final RxList<Song> songQueue = <Song>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isShuffled = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
    audioPlayer.currentIndexStream.listen((index) {
      currentIndex.value = index ?? 0;
    });
    audioPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playNext();
      }
    });

    audioPlayer.printError();
  }

  void playNext() async {
    if (isShuffled.value) {
      currentIndex.value = (currentIndex.value + 1) % songQueue.length;
    } else {
      currentIndex.value = (currentIndex.value + 1) % songQueue.length;
    }
    await audioPlayer.seek(Duration.zero, index: currentIndex.value);
    await audioPlayer.play();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
    songQueue.clear();
    currentIndex.value = 0;
    isPlaying.value = false;
    isShuffled.value = false;
  }

  void playPrevious() async {
    if (isShuffled.value) {
      currentIndex.value = (currentIndex.value - 1) % songQueue.length;
    } else {
      currentIndex.value = (currentIndex.value - 1) % songQueue.length;
    }
    await audioPlayer.seek(Duration.zero, index: currentIndex.value);
    await audioPlayer.play();
  }

  void playSong(int index) async {
    currentIndex.value = index;
    await audioPlayer.seek(Duration.zero, index: index);
    await audioPlayer.play();
  }

  void playPause() async {
    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  void addSongtoQueue(Song song) {
    songQueue.clear();
    songQueue.add(song);
    playSong(0);
  }

  void removeSongFromQueue(int index) {
    songQueue.removeAt(index);
    if (currentIndex.value >= songQueue.length) {
      currentIndex.value = songQueue.length - 1;
    }
    if (songQueue.isEmpty) {
      audioPlayer.stop();
    } else {
      playSong(currentIndex.value);
    }
  }

  void clearQueue() {
    songQueue.clear();
    currentIndex.value = 0;
    isPlaying.value = false;
    audioPlayer.stop();
  }

  void AddSongsToQueue(Songs songs) {
    songQueue.clear();
    songQueue.addAll(songs.songs);

    playPause();
  }

  void AddPLaylistToQueue(PlaylistWithSongs playlist) {
    songQueue.clear();
    songQueue.addAll(playlist.songs.songs);

    playPause();
  }

  void shuffleQueue() {
    isShuffled.value = !isShuffled.value;
    if (isShuffled.value) {
      songQueue.shuffle();
    } else {
      songQueue.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void seekTo(Duration position) async {
    await audioPlayer.seek(position);
  }

  void seekToSeconds(int seconds) async {
    await audioPlayer.seek(Duration(seconds: seconds));
  }

  void AddAlbumToQueue(AlbumWithSongs album) {
    songQueue.clear();
    songQueue.addAll(album.songs.songs);

    playSong(currentIndex.value);
  }

  void AddArtistToQueue(ArtistWithSongs artist) {
    songQueue.clear();
    songQueue.addAll(artist.songs.songs);

    playSong(currentIndex.value);
  }
}

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:just_audio_background/just_audio_background.dart';
part 'changer.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  final RxList<Song> songQueue = <Song>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isShuffled = false.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
    audioPlayer.currentIndexStream.listen((index) {
      currentIndex.value = index ?? 0;
    });
    audioPlayer.printError();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
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
      await audioPlayer.play();
    }
  }

  void addSongtoQueue(Song song) {
    if (songQueue.isEmpty) {
      songQueue.add(song);
      playSong(0);
    } else {
      songQueue.clear();
      songQueue.add(song);
      playSong(0);
    }
  }

  void removeSongFromQueue(int index) {
    songQueue.removeAt(index);
  }

  void clearQueue() {
    songQueue.clear();
  }

  void AddSongsToQueue(Songs songs) {
    songQueue.addAll(songs.songs);
  }

  void AddPLaylistToQueue(PlaylistWithSongs playlist) {
    songQueue.addAll(playlist.songs.songs);
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
    songQueue.addAll(album.songs.songs);
  }

  void AddArtistToQueue(ArtistWithSongs artist) {
    songQueue.addAll(artist.songs.songs);
  }
}

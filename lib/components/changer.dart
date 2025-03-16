part of 'audio_controller.dart';

AudioSource songToAudio(Song song) {
  print("songToAudio: ${song.title}");
  return AudioSource.uri(
    Uri.parse(song.url),
    tag: MediaItem(
      id: song.id.toString(),
      title: song.title,
      artist: song.artist,
      artUri: Uri.parse(song.imageUrl),
    ),
  );
}

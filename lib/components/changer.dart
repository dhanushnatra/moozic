part of 'audio_controller.dart';

AudioSource songToAudio(Song song) {
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

List<AudioSource> songstoAudio(Songs songs) {
  return songs.songs.map((song) {
    return AudioSource.uri(
      Uri.parse(song.url),
      tag: MediaItem(
        id: song.id.toString(),
        title: song.title,
        artist: song.artist,
        artUri: Uri.parse(song.imageUrl),
      ),
    );
  }).toList();
}

List<AudioSource> playlistToAudio(PlaylistWithSongs playlist) {
  return playlist.songs.songs.map((song) {
    return AudioSource.uri(
      Uri.parse(song.url),
      tag: MediaItem(
        id: song.id.toString(),
        title: song.title,
        artist: song.artist,
        artUri: Uri.parse(song.imageUrl),
      ),
    );
  }).toList();
}

List<AudioSource> albumToAudio(AlbumWithSongs albums) {
  return albums.songs.songs.map((song) {
    return AudioSource.uri(
      Uri.parse(song.url),
      tag: MediaItem(
        id: song.id.toString(),
        title: song.title,
        artist: song.artist,
        artUri: Uri.parse(song.imageUrl),
      ),
    );
  }).toList();
}

List<AudioSource> artistToAudio(ArtistWithSongs artists) {
  return artists.songs.songs.map((song) {
    return AudioSource.uri(
      Uri.parse(song.url),
      tag: MediaItem(
        id: song.id.toString(),
        title: song.title,
        artist: song.artist,
        artUri: Uri.parse(song.imageUrl),
      ),
    );
  }).toList();
}

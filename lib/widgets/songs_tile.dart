import 'package:flutter/material.dart';
import 'package:saavnapi/saavnapi.dart';

Widget buildSongTile(Song song) {
  return ListTile(
    leading: CircleAvatar(backgroundImage: NetworkImage(song.imageUrl)),
    title: Text(song.title),
    subtitle: Text(song.artist),
  );
}

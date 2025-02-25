import 'package:moozic/main.dart';
import 'package:moozic/screens/music.dart';
import 'package:flutter/material.dart';

Widget bottomplayer(context) {
  return GestureDetector(
    onTap: () {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const MusicScreen()),
      );
    },
    child: Container(
      height: 78,
      color: Colors.green.shade900.withOpacity(0.1),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            "https://c.saavncdn.com/430/DJ-Tillu-Telugu-2022-20220210033850-150x150.jpg",

            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Now Playing",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                print("previous");
              },
              icon: const Icon(Icons.skip_previous),
            ),
            IconButton(
              onPressed: () {
                print("play");
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.green.shade900,
              ),
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                print("next");
              },
              icon: const Icon(Icons.skip_next),
            ),
          ],
        ),
        subtitle: Text("artist name"),
      ),
    ),
  );
}

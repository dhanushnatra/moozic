import 'package:flutter/material.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Playlist",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("Playlist")),
    );
  }
}

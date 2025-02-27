import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:moozic/bottomBar.dart';
import 'package:saavnapi/saavnapi.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;
  const PlaylistScreen({super.key, required this.playlist});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.playlist.imageUrl,
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.playlist.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            buildPlaylistList(widget.playlist),
          ],
        ),
      ),
    );
  }

  Widget buildPlaylistList(Playlist playlist) {
    return FutureBuilder<PlaylistWithSongs>(
      future: SaavnApi().playlists.getplaylistsongs(
        playlist,
      ), // Replace with your actual future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.songs.songs.isEmpty) {
          return const Center(child: Text('No songs available'));
        } else {
          final songs = snapshot.data!.songs;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.songs.length,
            itemBuilder: (context, index) {
              final song = songs.songs[index];
              return ListTile(
                leading: Image.network(song.imageUrl),
                title: Text(song.title),
                subtitle: Text(song.artist),
                onTap: () {
                  print(
                    "playing ${song.title}",
                  ); // Replace with your audio player logic
                },
              );
            },
          );
        }
      },
    );
  }
}

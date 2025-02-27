import 'package:flutter/material.dart';
import 'package:moozic/screens/playlist.dart';
import 'package:moozic/components/AudioProvider.dart';
import 'package:saavnapi/saavnapi.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final AudioController audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Moozic",
          style: TextStyle(
            fontFamily: "Modak",
            fontSize: 40,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.green, size: 37),
            onPressed: () {
              print("settings");
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "Trending Playlists",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 200, child: buildPlaylistList()),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "Trending Albums",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 200, child: buildAlbumsList()),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending Songs",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("play all");
                    },
                    child: Row(
                      children: [
                        Text("play all"),
                        Icon(
                          Icons.play_circle_filled_sharp,
                          color: Colors.green,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(child: buildSongsList()),
          ],
        ),
      ),
    );
  }

  Widget buildPlaylistList() {
    return FutureBuilder<Playlists>(
      future: SaavnApi().playlists.trending(language: "telugu"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.playlists.isEmpty) {
          return const Center(child: Text("No playlists found"));
        } else {
          final playlists = snapshot.data!.playlists;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              return buildPlaylistTile(playlists[index]);
            },
          );
        }
      },
    );
  }

  Widget buildAlbumsList() {
    return FutureBuilder<Albums>(
      future: SaavnApi().albums.trending(language: "telugu"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.albums.isEmpty) {
          return const Center(child: Text("No albums found"));
        } else {
          final albums = snapshot.data!.albums;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: albums.length,
            itemBuilder: (context, index) {
              return buildAlbumTile(albums[index]);
            },
          );
        }
      },
    );
  }

  Widget buildAlbumTile(Album album) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 80, 41),
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(album.imageUrl),
          ),
          Text(
            album.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlaylistTile(Playlist playlist) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => PlaylistScreen(playlist: playlist),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500),
        );
        print("playing ${playlist.title}");
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 80, 41),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(playlist.imageUrl),
            ),
            Text(
              playlist.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSongsList() {
    return FutureBuilder<Songs>(
      future: SaavnApi().songs.trending(language: "telugu"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.songs.isEmpty) {
          return const Center(child: Text("No songs found"));
        } else {
          final songs = snapshot.data!.songs;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return buildSongTile(songs[index]);
            },
          );
        }
      },
    );
  }

  Widget buildSongTile(Song song) {
    return ListTile(
      onTap: () {
        print("playing ${song.title}");
      },
      title: Text(song.title, style: TextStyle(color: Colors.green.shade500)),
      subtitle: Text(song.artist),
      leading: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(song.imageUrl),
        ),
      ),
    );
  }
}

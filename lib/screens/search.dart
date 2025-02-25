import 'package:flutter/material.dart';
import 'package:saavnapi/saavnapi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool submit = false;
  void onsubmit() {
    setState(() {
      submit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(
            fontFamily: "Modak",
            fontSize: 30,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildSearchBar(),
          submit
              ? Flexible(
                child: DefaultTabController(length: 4, child: buildTabBar()),
              )
              : Container(),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return Column(
      children: [
        const TabBar(
          tabs: [
            Tab(text: "Songs"),
            Tab(text: "Albums"),
            Tab(text: "Artists"),
            Tab(text: "Playlists"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              songresults(_controller.text),
              albumresults(_controller.text),
              artistresults(_controller.text),
              playlistresults(_controller.text),
            ],
          ),
        ),
      ],
    );
  }

  Widget artistresults(query) {
    return FutureBuilder<Artists>(
      future: SaavnApi().artists.fetchArtists(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.artists.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.artists.length,
              itemBuilder:
                  (context, index) => artisttile(snapshot.data!.artists[index]),
            ),
          );
        }
      },
    );
  }

  Widget artisttile(Artist artist) {
    return ListTile(
      title: Text(artist.title, style: TextStyle(color: Colors.green.shade500)),
      leading: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(artist.imageUrl),
        ),
      ),
    );
  }

  Widget playlistresults(query) {
    return FutureBuilder<Playlists>(
      future: SaavnApi().playlists.fetchPlaylists(query, n: "20"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.playlists.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.playlists.length,
              itemBuilder:
                  (context, index) =>
                      playlisttile(snapshot.data!.playlists[index]),
            ),
          );
        }
      },
    );
  }

  Widget playlisttile(Playlist playlist) {
    return ListTile(
      title: Text(
        playlist.title,
        style: TextStyle(color: Colors.green.shade500),
      ),
      leading: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(playlist.imageUrl),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _controller,
        onSubmitted: (value) => onsubmit(),
        decoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.green.shade900,
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget albumresults(query) {
    return FutureBuilder<Albums>(
      future: SaavnApi().albums.fetchAlbums(query, n: "20"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.albums.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.albums.length,
              itemBuilder:
                  (context, index) => albumtile(snapshot.data!.albums[index]),
            ),
          );
        }
      },
    );
  }

  Widget albumtile(Album album) {
    return ListTile(
      title: Text(album.title, style: TextStyle(color: Colors.green.shade500)),
      subtitle: Text(album.title),
      leading: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.green)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(album.imageUrl),
        ),
      ),
    );
  }

  Widget songresults(query) {
    return FutureBuilder<Songs>(
      future: SaavnApi().songs.fetchSongs(query, n: "20"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.songs.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.songs.length,
              itemBuilder:
                  (context, index) => songtile(snapshot.data!.songs[index]),
            ),
          );
        }
      },
    );
  }

  Widget songtile(Song song) {
    return ListTile(
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moozic/screens/music.dart';
import 'package:saavnapi/saavnapi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool submit = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void tabchange(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  void onsubmit() {
    setState(() {
      submit = true;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(text: "Songs"),
                          Tab(text: "Albums"),
                          Tab(text: "Artists"),
                          Tab(text: "Playlists"),
                        ],
                        indicatorColor: Colors.green,
                        labelColor: Colors.green,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            songresults(_controller.text),
                            albumresults(_controller.text),
                            artistresults(_controller.text),
                            playlistresults(_controller.text),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SearchBar(
        controller: _controller,
        onSubmitted: (value) => onsubmit(),
        hintText: "Search",
        textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
        trailing: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () => onsubmit(),
          ),
        ],
        backgroundColor: WidgetStateProperty.all(Colors.green.shade900),
      ),
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
          return ListView.builder(
            itemCount: snapshot.data!.artists.length,
            itemBuilder:
                (context, index) => artisttile(snapshot.data!.artists[index]),
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
          return ListView.builder(
            itemCount: snapshot.data!.playlists.length,
            itemBuilder:
                (context, index) =>
                    playlisttile(snapshot.data!.playlists[index]),
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
          return ListView.builder(
            itemCount: snapshot.data!.albums.length,
            itemBuilder:
                (context, index) => albumtile(snapshot.data!.albums[index]),
          );
        }
      },
    );
  }

  Widget albumtile(Album album) {
    return ListTile(
      title: Text(album.title),
      subtitle: Text(album.title),
      leading: Container(
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
          return ListView.builder(
            itemCount: snapshot.data!.songs.length,
            itemBuilder:
                (context, index) => songtile(snapshot.data!.songs[index]),
          );
        }
      },
    );
  }

  Widget songtile(Song song) {
    return ListTile(
      title: Text(song.title),
      subtitle: Text(song.artist),
      leading: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(song.imageUrl),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.favorite_border_outlined),
            onPressed: () {
              // audioController.playTrack(song.url, song.title);
              print("adding to fav ${song.title}");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded),
            onPressed: () {
              // audioController.playTrack(song.url, song.title);

              print("more ${song.title}");
            },
          ),
        ],
      ),
      onTap: () {
        Get.to(() => MusicScreen(song: song));
        print("playing ${song.title}");
      },
    );
  }
}

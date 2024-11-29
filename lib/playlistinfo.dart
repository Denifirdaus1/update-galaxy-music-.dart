import 'package:flutter/material.dart';
import 'package:galaxy_music/history.dart';
import 'package:galaxy_music/login.dart';
import 'package:galaxy_music/premiumaccest.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/songlist.dart';
import 'package:galaxy_music/artis_list.dart';
import 'package:galaxy_music/collection.dart';
import 'package:galaxy_music/account.dart';
import 'package:galaxy_music/playpage.dart';
import 'package:galaxy_music/setting.dart';
import 'package:galaxy_music/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:galaxy_music/homepage.dart';
class Playlistinfo extends StatefulWidget {
  const Playlistinfo({super.key});

  @override
  State<Playlistinfo> createState() => _PlaylistinfoState();
}

class _PlaylistinfoState extends State<Playlistinfo> {
  final List<Map<String, String>> songPlaylistinfo = const [
    {'title': 'Stay', 'artist': 'Justin Bieber'},
    {'title': 'Ghost', 'artist': 'Justin Bieber'},
    {'title': 'Baby', 'artist': 'Justin Bieber'},
    {'title': 'Sorry', 'artist': 'Justin Bieber'},
    {'title': 'Beauty and a Beat', 'artist': 'Justin Bieber'},
    {'title': 'Changes', 'artist': 'Justin Bieber'},
  ];

  bool _isMiniPlayerClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with the black box for the image
          Container(
            height: 300,
            color: Colors.black,
            child: Center(
              child: Image.asset(
                'assets/artist_photo.jpg', // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20), // Add spacing below the black box
          // Row for artist avatar and name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: const AssetImage(
                    'assets/artist_avatar.jpg', // Replace with your avatar image asset
                  ),
                  backgroundColor: Colors.grey[700],
                ),
                const SizedBox(width: 10), // Add spacing between avatar and text
                const Text(
                  "Your Playlist", // Replace with the actual artist name
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // List of songs
          Expanded(
            child: ListView.builder(
              itemCount: songPlaylistinfo.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(Icons.music_note, color: Colors.white),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      songPlaylistinfo[index]['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    songPlaylistinfo[index]['artist']!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    // Handle item tap
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mini Player
          GestureDetector(
            onTap: () {
              setState(() {
                _isMiniPlayerClicked = !_isMiniPlayerClicked;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MusicPlayerScreen()),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.music_note, color: Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'This music',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Artist name',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                    onPressed: () {
                      // Handle play action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      // Handle add action
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromARGB(255, 118, 148, 148),
            unselectedItemColor: const Color.fromARGB(255, 118, 148, 148),
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusicSearchPage()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Collection()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountScreen()),
                  );
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

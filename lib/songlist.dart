import 'package:flutter/material.dart';
import 'package:galaxy_music/homepage.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/collection.dart';
import 'package:galaxy_music/account.dart';
import 'package:galaxy_music/playpage.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}
@override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }

class _listState extends State<list> {
  bool _isMiniPlayerClicked = false;

  final List<Map<String, String>> songlist = const [
    {'title': 'Name Song 1', 'artist': 'Artist 1'},
    {'title': 'Name Song 2', 'artist': 'Artist 2'},
    {'title': 'Name Song 3', 'artist': 'Artist 3'},
    {'title': 'Name Song 4', 'artist': 'Artist 4'},
    {'title': 'Name Song 5', 'artist': 'Artist 5'},
    {'title': 'Name Song 6', 'artist': 'Artist 6'},
    {'title': 'Name Song 7', 'artist': 'Artist 7'},
    {'title': 'Name Song 8', 'artist': 'Artist 8'},
    {'title': 'Name Song 9', 'artist': 'Artist 9'},
    {'title': 'Name Song 10', 'artist': 'Artist 10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Centered "Recently Played" text
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'More Music',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          // ListView for song list
          Expanded(
            child: ListView.builder(
              itemCount: songlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey, // Placeholder for album art
                      borderRadius: BorderRadius.circular(12.0), // Added corner radius
                    ),
                    child: const Icon(Icons.music_note, color: Colors.white),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0), // Added space below title
                    child: Text(
                      songlist[index]['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    songlist[index]['artist']!,
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
                MaterialPageRoute(builder: (context) => const MusicPlayerScreen()),
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
                    child: Center(
                      child: Icon(Icons.music_note, color: Colors.grey[700]),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
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
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {},
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
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MusicSearchPage()),
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
                    MaterialPageRoute(builder: (context) => const AccountScreen()),
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

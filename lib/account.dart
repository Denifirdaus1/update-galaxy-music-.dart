import 'package:flutter/material.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/collection.dart';
import 'package:galaxy_music/homepage.dart';
import 'package:galaxy_music/playpage.dart';
import 'package:galaxy_music/setting.dart';
import 'package:galaxy_music/theme_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isMiniPlayerClicked = false;
  int _currentIndex = 3; // Account page index

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section dengan LayoutBuilder
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Avatar
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey[800],
                                  child: const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Info pengguna
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Account Name',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'ID User: 210474',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Playlist Section
                  const Text(
  'Your Playlist',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
                  const SizedBox(height: 16),
                  Wrap(
  spacing: 12, // Jarak horizontal antar elemen
  runSpacing: 16, // Jarak vertikal antar elemen jika membungkus
  children: List.generate(
    5,
    (index) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Name Playlist',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    ),
  ),
),
                  const SizedBox(height: 32),

                  // Favorite Song Section
                  const Text(
  'Your Favorite Song',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
                  const SizedBox(height: 16),
                 Wrap(
  spacing: 12, // Jarak horizontal antar elemen
  runSpacing: 16, // Jarak vertikal antar elemen jika membungkus
  children: List.generate(
    5,
    (index) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Name Song',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Artist',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    ),
  ),
),
                  const SizedBox(height: 32),

                  // History Section
                  const Text(
  'History',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
                  const SizedBox(height: 16),
                 Wrap(
  spacing: 12, // Jarak horizontal antar elemen
  runSpacing: 16, // Jarak vertikal antar elemen jika membungkus
  children: List.generate(
    5,
    (index) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Music Name',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    ),
  ),
),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildMiniPlayer(),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPlaylistGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 48) / 3; // 3 items per row with spacing
        return Wrap(
          spacing: 12,
          runSpacing: 16,
          children: List.generate(
            5,
            (index) => SizedBox(
              width: itemWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Name Playlist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoriteSongGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 48) / 3;
        return Wrap(
          spacing: 12,
          runSpacing: 16,
          children: List.generate(
            5,
            (index) => SizedBox(
              width: itemWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Name Song',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'Artist',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 48) / 3;
        return Wrap(
          spacing: 12,
          runSpacing: 16,
          children: List.generate(
            5,
            (index) => SizedBox(
              width: itemWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Music Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniPlayer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMiniPlayerClicked = !_isMiniPlayerClicked;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Setting()),
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
              child: Icon(Icons.music_note, color: Colors.grey[700]),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'This Music',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Artist Name',
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
  icon: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
  onPressed: () {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Image and Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Favorit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Private Favorit',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Colors.black38,
                thickness: 1,
                height: 20,
              ),
              // Actions
              ListTile(
                leading: const Icon(Icons.add, color: Colors.black),
                title: const Text(
                  'Add to this Favorit',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color.fromARGB(255, 0, 0, 0)),
                ),
                onTap: () {
                  // Handle action
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.black),
                title: const Text(
                  'Edit this Favorit',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color.fromARGB(255, 0, 0, 0)),
                ),
                onTap: () {
                  // Handle action
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.black),
                title: const Text(
                  'Delete this Favorit',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color.fromARGB(255, 0, 0, 0)),
                ),
                onTap: () {
                  // Handle action
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.black),
                title: const Text(
                  'Share this Favorit',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black),
                ),
                onTap: () {
                  // Handle action
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  },
),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      selectedItemColor: const Color.fromARGB(255, 118, 148, 148),
            unselectedItemColor: const Color.fromARGB(255, 118, 148, 148),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MusicSearchPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Collection()),
            );
            break;
          case 3:
            // Already on Collection page
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
    );
  }
}

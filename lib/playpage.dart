import 'package:flutter/material.dart';
import 'package:galaxy_music/homepage.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Action for menu
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview Image Lagu
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
              image: DecorationImage(
                image: AssetImage('assets/song_preview.jpg'), // Tambahkan path gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Bagian atas: Gambar kecil lagu dan informasi lagu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Kotak gambar kecil lagu
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Judul lagu dan artis
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Song Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Artist Name',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Slider(
                  value: 20,
                  min: 0,
                  max: 100,
                  activeColor: const Color.fromARGB(255, 0, 17, 255),
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    // Handle slider change
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1:30',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '4:20',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                iconSize: 48,
                onPressed: () {
                  // Action for previous song
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Color.fromARGB(255, 255, 255, 255)),
                iconSize: 64,
                onPressed: () {
                  // Action for play/pause
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                iconSize: 48,
                onPressed: () {
                  // Action for next song
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Lyrics Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24.0),
                ),
              ),
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Song Lyrics\n\n'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. \n'
                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n'
                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris \n'
                      'nisi ut aliquip ex ea commodo consequat.\n\n'
                      'Duis aute irure dolor in reprehenderit in voluptate velit esse \n'
                      'cillum dolore eu fugiat nulla pariatur.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

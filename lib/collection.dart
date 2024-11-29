import 'package:flutter/material.dart';
import 'package:galaxy_music/playlistinfo.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/homepage.dart';
import 'package:galaxy_music/account.dart';
import 'package:galaxy_music/playpage.dart';
import 'package:galaxy_music/artis_list.dart';

class Collection extends StatefulWidget {
  const Collection({super.key});

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  bool _isMiniPlayerClicked = false;
  int _currentIndex = 2; // Collection page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSidebar(), // Make sure this widget exists
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
                left: 1.0,    // Mengurangi padding kiri
                right: 12.0,   // Mengurangi padding kanan
                top: 35.0,      // Mengurangi padding atas
                bottom: 16.0,  // Mempertahankan padding bawah untuk spacing
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              _buildHeader(),
              const SizedBox(height: 20),
              
              // My Playlist Section
              _buildPlaylistSection(),
              const SizedBox(height: 20),
              
              // My Favorite Section
              _buildFavoriteSection(),
              const SizedBox(height: 20),
              
              // Favorite Artist Section
              _buildArtistSection(),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMiniPlayer(),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                       
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color.fromARGB(255, 80, 133, 182), size: 28),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MusicSearchPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'My Playlist',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: 6,
            itemBuilder: (context, index) {
              if (index < 5) {
                return _buildPlaylistItem('Playlist ${index + 1}');
              }
              return _buildAddNewPlaylistItem();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaylistItem(String name) {
    return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 4),
  child: Column(
    children: [
      GestureDetector( // Wrap the Container with GestureDetector
        onTap: () {
              setState(() {
                _isMiniPlayerClicked = !_isMiniPlayerClicked;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Playlistinfo()),
              );
            },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(
              Icons.music_note,
              color: Colors.grey[300],
              size: 40,
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        name, // Ensure 'name' is passed as a parameter to this widget
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    ],
  ),
);

  }

  Widget _buildAddNewPlaylistItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Add new playlist logic
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[600]!, width: 2),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey[300],
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add new',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'My Favorite',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 116,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: 6,
            itemBuilder: (context, columnIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: List.generate(2, (rowIndex) {
                    final index = columnIndex * 2 + rowIndex;
                    if (index >= 11) return const SizedBox.shrink();
                    if (index < 11) {
                      return _buildFavoriteItem('Song ${index + 1}');
                    }
                    return _buildAddNewFavoriteItem();
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Center(
              child: Icon(
                Icons.music_note,
                color: Colors.grey[300],
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewFavoriteItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Add new favorite logic
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[600]!, width: 2),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey[300],
                  size: 30,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Add new',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Favorite Artist',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: 6,
            itemBuilder: (context, index) {
              if (index < 5) {
                return _buildArtistItem('Artist ${index + 1}');
              }
              return _buildAddNewArtistItem();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArtistItem(String name) {
    return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child: Column(
    children: [
      GestureDetector( // Wrap CircleAvatar with GestureDetector
        onTap: () {
              setState(() {
                _isMiniPlayerClicked = !_isMiniPlayerClicked;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ArtisList()),
              );
            },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[800],
          child: Icon(
            Icons.person,
            color: Colors.grey[300],
            size: 40,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        name, // Ensure 'name' is passed as a parameter to this widget
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    ],
  ),
);

  }

  Widget _buildAddNewArtistItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Add new artist logic
            },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[800],
              child: Icon(
                Icons.add,
                color: Colors.grey[300],
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add new',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
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
              child: Icon(Icons.music_note, color: Colors.grey[700]),
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
                  ),
                  Text(
                    'Artist Name',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.black,
              onPressed: () {},
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
            // Already on Collection page
            break;
          case 3:
            Navigator.pushReplacement(
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
    );
}
}

import 'package:flutter/material.dart';
import 'package:galaxy_music/downloader.dart';
import 'package:galaxy_music/history.dart';
import 'package:galaxy_music/login.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/artis_list.dart';
import 'package:galaxy_music/collection.dart';
import 'package:galaxy_music/account.dart';
import 'package:galaxy_music/playpage.dart';
import 'package:galaxy_music/setting.dart';
import 'package:galaxy_music/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

// Halaman utama aplikasi
class HomeScreen extends StatefulWidget {
  // Changed to StatefulWidget
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMiniPlayerClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSidebar(),
      body: Column(
        children: [
          // Main content in Expanded to allow for bottom widgets
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 12.0, // Mengurangi padding kiri
                right: 12.0, // Mengurangi padding kanan
                top: 35.0, // Mengurangi padding atas
                bottom: 16.0, // Mempertahankan padding bawah untuk spacing
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header dengan profil dan username
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context)
                              .openDrawer(); // Membuka sidebar saat foto profil diklik
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7), // Sesuaikan padding
                          decoration: BoxDecoration(
                            color: Colors
                                .grey[800], // Warna latar belakang username
                            borderRadius:
                                BorderRadius.circular(15), // Sudut melengkung
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min, // Agar tidak meluas
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors
                                    .grey, // Placeholder untuk foto profil
                              ),
                              SizedBox(
                                  width:
                                      5), // Jarak antara foto profil dan username
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                      height: 20), // Jarak antara header dan bagian selanjutnya

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[850], // Warna latar belakang
                      borderRadius:
                          BorderRadius.circular(14), // Sudut melengkung
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recommendation',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Jarak ke konten berikutnya
                        // Scroll horizontal untuk card album
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              songs.length,
                              (index) => index < songs.length
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Buat path audio yang konsisten
                                          String audioPath =
                                              'music/${_formatAudioFileName(songs[index]['title']!)}.mp3';
                                          //ganti menjadi path music
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MusicPlayer(
                                                songTitle: songs[index]
                                                    ['title']!,
                                                artistName: songs[index]
                                                    ['artist']!,
                                                imagePath: songs[index]
                                                    ['image']!,
                                                audioPath: audioPath,
                                              ),
                                            ),
                                          );
                                        },
                                        child: buildAlbumCard(
                                          width: 100,
                                          height: 100,
                                          borderRadius: 14,
                                          title: songs[index]['title']!,
                                          subtitle: songs[index]['artist']!,
                                          imagePath: songs[index]['image']!,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian "That you might like"
                  const Text(
  'That you might like',
  style: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Warna teks
  ),
),
const SizedBox(height: 10),
// Daftar lagu yang mungkin disukai
buildSuggestedSongs(
  context: context,
  cardSpacing: 10.0,
  imageWidth: 50.0,
  imageHeight: 50.0,
  borderRadius: 8.0,
),
                  const SizedBox(height: 20),

                  // Bagian "Suggested Artists"
const Text(
  'Suggested artists',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white, // Warna teks
  ),
),
const SizedBox(height: 10),
// Scroll horizontal untuk kartu artis
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      // Kartu artis pertama
      Padding(
        padding: const EdgeInsets.only(right: 20.0), // Jarak antar card artis
        child: buildArtistCard(
          imagePath: 'assets/artis/adele.jpg', // Ganti dengan path gambar artis
          name: 'Adele',
          radius: 50.0,
        ),
      ),
      // Kartu artis kedua
      Padding(
        padding: const EdgeInsets.only(right: 20.0), // Jarak antar card artis
        child: buildArtistCard(
          imagePath: 'assets/artis/bernadya.jpg', // Ganti dengan path gambar artis
          name: 'Bernadya',
          radius: 50.0,
        ),
      ),
      // Kartu artis ketiga
      Padding(
        padding: const EdgeInsets.only(right: 20.0), // Jarak antar card artis
        child: buildArtistCard(
          imagePath: 'assets/artis/bruno mars.jpg', // Ganti dengan path gambar artis
          name: 'Bruno Mars',
          radius: 50.0,
        ),
      ),
      // Kartu artis keempat
      Padding(
        padding: const EdgeInsets.only(right: 20.0), // Jarak antar card artis
        child: buildArtistCard(
          imagePath: 'assets/artis/maher zain.jpg', // Ganti dengan path gambar artis
          name: 'Maher Zain',
          radius: 50.0,
        ),
      ),
      // Kartu artis kelima
      Padding(
        padding: const EdgeInsets.only(right: 20.0), // Jarak antar card artis
        child: buildArtistCard(
          imagePath: 'assets/artis/the weeknd.jpg', // Ganti dengan path gambar artis
          name: 'The Weekend',
          radius: 50.0,
        ),
      ),
    ],
  ),
),

                  const SizedBox(height: 20),
                  // Bagian Today’s Biggest Hits
                  const Text(
                    "Today’s Biggest Hits",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        songs.length,
                        (index) => index < songs.length
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, songs[index]['link']!);
                                  },
                                  child: buildAlbumCard(
                                    width: 100,
                                    height: 100,
                                    borderRadius: 14,
                                    title: songs[index]['title']!,
                                    subtitle: songs[index]['artist']!,
                                    imagePath: songs[index]['image']!,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian More Like (Adele)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "More Like",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                            Icons.more_horiz), // Ikon menu untuk opsi lainnya
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArtisList()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Profil Adele dengan border bundar dan teks di sampingnya
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(
                            'assets/artis/bernadya.jpg'), // Tambahkan path gambar profil
                        backgroundColor: Colors.grey[
                            700], // Tetap gunakan background color sebagai fallback
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Bernadya",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // List album yang similar song
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        similarSongs.length,
                        (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Buat path audio yang konsisten
                                          String audioPath =
                                              'music/${_formatAudioFileName(similarSongs[index]['title']!)}.mp3';
                                          //ganti menjadi path music
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MusicPlayer(
                                                songTitle: similarSongs[index]
                                                    ['title']!,
                                                artistName: similarSongs[index]
                                                    ['artist']!,
                                                imagePath: similarSongs[index]
                                                    ['image']!,
                                                audioPath: audioPath,
                                              ),
                                            ),
                                          );
                                        },
                                        child: buildAlbumCard(
                                          width: 100,
                                          height: 100,
                                          borderRadius: 14,
                                          title: similarSongs[index]['title']!,
                                          subtitle: similarSongs[index]['artist']!,
                                          imagePath: similarSongs[index]['image']!,
                                        ),
                                      ),
                                    )
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian Galaxy Top Artists
                  const Text(
                    "Galaxy Top Artists",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildArtistInfoCard(
                          artistName: "The Weeknd",
                          songs: [
                            "1. Timeless",
                            "2. One Of The Girls",
                            "3. Starboy"
                          ],
                          profileImage: CircleAvatar(
                            radius: 30, // Sesuaikan ukuran sesuai desain
                            backgroundColor: Colors.grey[700],
                            child: const Text("T",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .bold)), // Ganti dengan gambar jika tersedia
                          ),
                        ),
                        const SizedBox(width: 10),
                        buildArtistInfoCard(
                          artistName: "Justin Bieber",
                          songs: ["1. Stay", "2. Ghost", "3. Love Yourself"],
                          profileImage: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[700],
                            child: const Text("J",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .bold)), // Ganti dengan gambar jika tersedia
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "New Add",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        songs.length,
                        (index) => index < songs.length
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, songs[index]['link']!);
                                  },
                                  child: buildAlbumCard(
                                    width: 100,
                                    height: 100,
                                    borderRadius: 14,
                                    title: songs[index]['title']!,
                                    subtitle: songs[index]['artist']!,
                                    imagePath: songs[index]['image']!,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Pop",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        songs.length,
                        (index) => index < songs.length
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, songs[index]['link']!);
                                  },
                                  child: buildAlbumCard(
                                    width: 100,
                                    height: 100,
                                    borderRadius: 14,
                                    title: songs[index]['title']!,
                                    subtitle: songs[index]['artist']!,
                                    imagePath: songs[index]['image']!,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Local Music",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        songs.length,
                        (index) => index < songs.length
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, songs[index]['link']!);
                                  },
                                  child: buildAlbumCard(
                                    width: 100,
                                    height: 100,
                                    borderRadius: 14,
                                    title: songs[index]['title']!,
                                    subtitle: songs[index]['artist']!,
                                    imagePath: songs[index]['image']!,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Sad Vibes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        songs.length,
                        (index) => index < songs.length
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, songs[index]['link']!);
                                  },
                                  child: buildAlbumCard(
                                    width: 100,
                                    height: 100,
                                    borderRadius: 14,
                                    title: songs[index]['title']!,
                                    subtitle: songs[index]['artist']!,
                                    imagePath: songs[index]['image']!,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bagian New Add
                  const Text(
                    "Relaxing",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        songs.length,
                        (index) => index < songs.length
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, songs[index]['link']!);
                                  },
                                  child: buildAlbumCard(
                                    width: 100,
                                    height: 100,
                                    borderRadius: 14,
                                    title: songs[index]['title']!,
                                    subtitle: songs[index]['artist']!,
                                    imagePath: songs[index]['image']!,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Mini Player
          GestureDetector(
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
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    icon:
                        const Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,
                        color: Color.fromARGB(255, 0, 0, 0)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  leading: const Icon(Icons.add,
                                      color: Colors.black),
                                  title: const Text(
                                    'Add to this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.edit,
                                      color: Colors.black),
                                  title: const Text(
                                    'Edit this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete,
                                      color: Colors.black),
                                  title: const Text(
                                    'Delete this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  onTap: () {
                                    // Handle action
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.share,
                                      color: Colors.black),
                                  title: const Text(
                                    'Share this Favorit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
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
                icon:
                    Icon(Icons.home, color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music,
                    color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,
                    color: Color.fromARGB(255, 110, 121, 134)),
                label: 'Account',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Keep all your existing widget builder methods here
  // buildAlbumCard, buildArtistCard, buildSuggestedSongs, buildArtistInfoCard
}

// Fungsi bantuan untuk format nama file
String _formatAudioFileName(String title) {
  return title
      .toLowerCase()
      .replaceAll(',', '')
      .replaceAll('&', 'and');
}

//Rekomendasi
final List<Map<String, String>> songs = [
  {
    'title': 'Skyfall',
    'artist': 'Adele',
    'link': '/music_player_skyfall',
    'image': 'assets/images/skyfall.jpeg', // Jalur gambar
  },
  {
    'title': 'Baby By Me',
    'artist': '50 cent',
    'link': '/music_player_2',
    'image': 'assets/images/baby by me.jpg',
  },
  {
    'title': 'Apa Mungkin',
    'artist': 'Bernadya',
    'link': '/music_player_3',
    'image': 'assets/images/apa mungkin.jpg',
  },
  {
    'title': 'Sunflower',
    'artist': 'Post Malone, Swae Lee',
    'link': '/music_player_3',
    'image': 'assets/images/sunflower.jpg',
  },
  {
    'title': 'Die With A Smile',
    'artist': 'Lady Gaga, Bruno Mars',
    'link': '/music_player_3',
    'image': 'assets/images/die with a smile.jpg',
  },
  {
    'title': 'Save Your Tears',
    'artist': 'The Weeknd',
    'image': 'assets/images/save your tears.jpg',
  },
  // Tambahkan lagu-lagu lainnya dengan cara yang sama
];

//More Like = Artis
final List<Map<String, String>> similarSongs = [
  {
    'title': 'Satu Bulan',
    'artist': 'Bernadya',
    'image': 'assets/images/satu bulan.jpg',
  },
  {
    'title': 'Untungnya Hidup Harus Tetap Berjalan',
    'artist': 'Bernadya',
    'image':'assets/images/untungnya hidup harus tetap berjalan.jpg',
  },
  {
    'title': 'kata Mereka ini Berlebihan',
    'artist': 'Bernadya',
    'image': 'assets/images/kata mereka ini berlebihan.jpg',
  },
  {
    'title': 'Apa Mungkin',
    'artist': 'Bernadya',
    'image': 'assets/images/apa mungkin.jpg',
  },
  {
    'title': 'Kini Mereka Tau',
    'artist': 'Bernadya',
    'image': 'assets/images/kini mereka tahu.jpg',
  },
];

//sugested song
final List<Map<String, String>> sugested = [
  {
    'title': 'Closed Doors',
    'artist': 'Ismail',
    'image': 'assets/images/closed doors.jpg',
  },
  {
    'title': 'Royalty',
    'artist': 'Egzod & Maestro Chives',
    'image': 'assets/images/royalty.jpg',
  },
  {
    'title': 'Snowman',
    'artist': 'Sia',
    'image': 'assets/images/snowman.jpg',
  },
  {
    'title': 'The Scientist',
    'artist': 'Coldplay',
    'image': 'assets/images/the scientist.jpg',
  },
];

// Widget untuk kartu album dengan ukuran dan radius yang dapat disesuaikan
// Widget untuk kartu album rekomendasi
Widget buildAlbumCard({
  required double width,
  required double height,
  required double borderRadius,
  required String title,
  required String subtitle,
  required String imagePath, // Tambahkan parameter untuk jalur gambar
}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[600], // Placeholder untuk gambar album
            borderRadius: BorderRadius.circular(
                borderRadius), // Sudut melengkung pada gambar
            image: DecorationImage(
              image: AssetImage(imagePath), // Menggunakan jalur gambar
              fit: BoxFit.cover, // Mengatur gambar agar sesuai dengan kontainer
            ),
          ),
        ),
        const SizedBox(height: 5), // Jarak ke teks judul album
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          overflow:
              TextOverflow.ellipsis, // Menghindari teks yang terlalu panjang
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

// Widget untuk kartu artis dengan radius yang dapat disesuaikan
Widget buildArtistCard({
  required String imagePath,
  required String name,
  required double radius,
}) {
  return Column(
    children: [
      Container(
        width: radius * 2, // Lebar gambar
        height: radius * 2, // Tinggi gambar
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imagePath), // Gambar artis
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        name,
        style: const TextStyle(
          color: Colors.white, // Warna teks nama artis
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
// Widget untuk daftar lagu yang mungkin disukai
Widget buildSuggestedSongs({
  required BuildContext context,
  required double cardSpacing,
  required double imageWidth,
  required double imageHeight,
  required double borderRadius,
}) {
  return Column(
    children: List.generate(sugested.length, (index) {
      return Padding(
        padding: EdgeInsets.only(bottom: cardSpacing), // Jarak antar lagu
        child: GestureDetector(
          onTap: () {
            // Buat path audio yang konsisten
            String audioPath = 'music/${_formatAudioFileName(sugested[index]['title']!)}.mp3';
            // Navigasi ke halaman PlayPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicPlayer(
                  songTitle: sugested[index]['title']!,
                  artistName: sugested[index]['artist']!,
                  imagePath: sugested[index]['image']!,
                  audioPath: audioPath,
                ),
              ),
            );
          },
          child: ListTile(
            leading: Container(
              width: imageWidth, // Lebar gambar lagu
              height: imageHeight, // Tinggi gambar lagu
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius), // Sudut melengkung pada gambar lagu
                image: DecorationImage(
                  image: AssetImage(sugested[index]['image']!), // Gambar lagu
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              sugested[index]['title']!,
              style: const TextStyle(color: Colors.white), // Warna teks judul
            ),
            subtitle: Text(
              sugested[index]['artist']!,
              style: TextStyle(color: Colors.grey[400]), // Warna teks artis
            ),
            trailing: const Icon(Icons.favorite_border, color: Colors.white), // Ikon favorit
          ),
        ),
      );
    }),
  );
}

// Widget untuk kartu artis dengan informasi daftar lagu
Widget buildArtistInfoCard({
  required String artistName,
  required List<String> songs,
  required Widget profileImage,
}) {
  return Container(
    width: 180,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            profileImage, // Profil bulat
            const SizedBox(width: 10), // Jarak antara profil dan nama artis
            Text(
              artistName,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
        const SizedBox(height: 10), // Jarak ke daftar lagu
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: songs
              .map((song) => Text(
                    song,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ))
              .toList(),
        ),
      ],
    ),
  );
}

// Sidebar kustom
class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Container(
        color: Colors.grey[800],
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5, // 80% tinggi layar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35), //jarak dari atas ke username
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Tambahkan aksi di sini, seperti navigasi ke halaman profil
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AccountScreen()), // Ganti dengan halaman tujuan
                      );
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          // Aksi untuk "See profile"
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountScreen()), // Ganti dengan halaman tujuan
                          );
                        },
                        child: const Text(
                          'See profile',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Sidebar Items
              SidebarItem(
                icon: const Icon(
                    Icons.switch_account), // Pastikan menggunakan Widget
                label: 'Switch Account',
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              const SizedBox(height: 5),
              SidebarItem(
                icon: const Icon(Icons.history), // Ikon berupa widget
                label: 'History',
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const History()),
                  );
                },
              ),

              const SizedBox(height: 5),
              SidebarItem(
                icon: const Icon(Icons.settings),
                label: 'Setting',
                textColor: Colors.white, // Warna solid untuk teks
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Setting()),
                  );
                },
              ),
              const SizedBox(height: 5),
              SidebarItem(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Theme.of(context).primaryColor, // Warna ikon
                ),
                label: 'Switch Theme',
                textColor: Theme.of(context).primaryColor,
                onTap: () {
                  themeProvider.toggleTheme();
                },
              ),

              const SizedBox(height: 20),
              const Text(
                'Premium Accest',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 10),
              ),
              const SizedBox(height: 10),
              SidebarItem(
                icon: Image.asset(
                  'assets/imgbg/music.png', // Path ke gambar Gmail
                  width: 30, // Ukuran gambar
                  height: 30,
                ),
                label: 'Galaxy AI',
                textColor: Colors.white, // Warna teks
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Setting()),
                  );
                },
              ),
              const SizedBox(height: 10),
              SidebarItem(
                icon: Image.asset(
                  'assets/imgbg/download.png',
                  width: 30, // Ukuran gambar
                  height: 30,
                ),
                label: 'Downloader',
                textColor: Colors.white, // Warna teks
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Downloader()),
                  );
                },
              ),

              const SizedBox(height: 70), //jarak dari setting ke premium akses

// Free Premium Access Button
              SidebarItem(
                icon: Row(
                  children: [
                    Image.asset(
                      'assets/imgbg/premium.png', // Path ke gambar premium
                      width: 24, // Ukuran gambar
                      height: 24,
                    ),
                    const SizedBox(width: 10), // Jarak antara gambar dan teks
                  ],
                ),
                label: 'Upgrade to Premium',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                centeredText: true,
                onTap: () {
                  // Menampilkan pop-up langsung saat tombol ditekan
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Mengatur agar pop-up sesuai konten
                          children: [
                            const Text(
                              'Premium',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 25, 110, 160),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Rp 54.990 selama 2 bulan\n'
                              'Rp 54.990/bulan sesudahnya',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Benefit\n',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                            const Text(
                              '• 1 akun Premium\n'
                              '• Akses ke Galaxy Ai\n'
                              '• Download local music',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Tambahkan aksi untuk tombol jika diperlukan
                                Navigator.pop(context); // Menutup pop-up
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // Warna latar belakang biru
                                foregroundColor:
                                    Colors.white, // Warna teks putih
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Sudut melengkung
                                ),
                              ),
                              child: const Text('Dapatkan Premium'),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Sudut melengkung pada pop-up
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 10),

// Sign Out Button
              SidebarItem(
                icon: const Icon(Icons.logout),
                label: 'Sign out',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                centeredText: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context), // Tutup dialog
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final Widget icon; // Diubah dari IconData ke Widget
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool centeredText;
  final VoidCallback? onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.centeredText = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: Row(
          mainAxisAlignment:
              centeredText ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            icon, // Menampilkan ikon berupa widget
            if (!centeredText) const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: textColor ?? Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

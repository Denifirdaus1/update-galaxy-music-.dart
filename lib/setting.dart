import 'package:flutter/material.dart';
import 'package:galaxy_music/history.dart';
import 'package:galaxy_music/homepage.dart';
import 'package:galaxy_music/login.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/collection.dart';
import 'package:galaxy_music/account.dart';
import 'package:galaxy_music/playpage.dart';
import 'package:galaxy_music/theme_provider.dart';
import 'package:provider/provider.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isMiniPlayerClicked = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Tindakan ketika tombol settings ditekan
            },
          ),
        ],
      ),
      drawer: const CustomSidebar(), // Menambahkan CustomSidebar ke dalam drawer
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Bagian pertama: Pengaturan Umum
            const Text(
              'General Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.translate),
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Aksi untuk mengganti bahasa
              },
            ),
            const Divider(),

            // Bagian kedua: Pengaturan Tema
            ListTile(
              leading: Icon(
                themeProvider.isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              title: const Text('Switch Theme'),
              onTap: () {
                themeProvider.toggleTheme();
              },
            ),
            const Divider(),

            // Bagian ketiga: Pengaturan Akun
            const SizedBox(height: 20),
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account Information'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman akun
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman history
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const History()),
                );
              },
            ),
            const Divider(),

            // Bagian kelima: Pengaturan Premium dan Logout
            const SizedBox(height: 20),
            const Text(
              'Subscription',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
  leading: const Icon(Icons.diamond_sharp),
  title: const Text(' Upgrade to Premium '),
  trailing: const Icon(Icons.arrow_forward_ios),
  onTap: () {
    // Menampilkan pop-up langsung saat tombol ditekan
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min, // Mengatur agar pop-up sesuai konten
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
    backgroundColor: Colors.blue, // Warna latar belakang biru
    foregroundColor: Colors.white, // Warna teks (opsional, putih untuk kontras)
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding tombol
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Sudut melengkung pada tombol
    ),
  ),
  child: const Text('Dapatkan Premium'),
),

            ],
          ),
          shape: const RoundedRectangleBorder(
          ),
        );
      },
    );
  },
),

            const Divider(),

            // Bagian terakhir: Logout
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () {
                // Tindakan logout
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Tutup dialog
                          },
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

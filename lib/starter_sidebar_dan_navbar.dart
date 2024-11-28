import 'package:flutter/material.dart';
import 'package:galaxy_music/search.dart';
import 'package:galaxy_music/homepage.dart';

class starter extends StatefulWidget {
  const starter({super.key});

  @override
  State<starter> createState() => _starterState();
}

class _starterState extends State<starter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const CustomSidebar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Builder untuk username dan foto profil
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
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Ikon Search di ujung kanan
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MusicSearchPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
      bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mini Player Bar
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0), // Margin to create space around the container
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
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
                  // Placeholder for Album Cover
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.music_note,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Song Title and Artist Name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  // Action Icons
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
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            BottomNavigationBar(
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                // Handle navigation when an item is tapped
                switch (index) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MusicSearchPage()));
                    break;
                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const starter()));
                    break;
                  case 3:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const starter()));
                    break;
                  default:
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
                  label: 'starter',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Account',
                ),
              ],
            ),
          ],
        )
    );
  }
}

// Sidebar kustom
class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[800],
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'See profile',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SidebarItem(
                icon: Icons.switch_account, label: 'Switch Account'),
            const SidebarItem(icon: Icons.history, label: 'History'),
            const SidebarItem(icon: Icons.settings, label: 'Setting'),
            const SizedBox(height: 230), // Spacing adjustment
            SidebarItem(
              icon: Icons.stars,
              label: 'Free Premium access',
              backgroundColor: Colors.black,
              iconColor: Colors.white,
              textColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              centeredText: true,
            ),
            const SizedBox(height: 15), // Adjusted space for flexibility
            SidebarItem(
              icon: Icons.logout,
              label: 'Sign out',
              backgroundColor: Colors.black,
              iconColor: Colors.white,
              textColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              centeredText: true,
            ),
          ],
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool centeredText;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.centeredText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment:
            centeredText ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor ?? Colors.white),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(color: textColor ?? Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

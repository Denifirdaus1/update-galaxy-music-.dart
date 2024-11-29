import 'package:flutter/material.dart';
import 'package:galaxy_music/login_pilihan.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              'asset/logo.png', // Ensure that this path is correct
              width: 240,
              height: 240,
            ),
            const SizedBox(height: 40),
            const Text(
              'A Galaxy of Music, Just for You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                height: 26.63 / 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                // Pindah ke halaman HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginChoicePage()), // Ganti dengan halaman tujuan
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF040D36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              child: const Text(
                'Explore the Galaxy',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 14.52 / 12,
                  color: Color(0xFF040D36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:galaxy_music/homepage.dart';

class CongratulationPage extends StatelessWidget {
  const CongratulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 35,
            left: -100,
            child: Image.asset(
              'assets/imgbg/anime nobg 1.png', // Adjust path to your asset
              width: 600,
              height: 600,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 380), // Adjust for proper vertical alignment
                const Text(
                  'Congratulation',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'are you ready',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
    // Pindah ke halaman HomePage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()), // Ganti dengan halaman tujuan
    );
  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Button color
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Ready',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:galaxy_music/login.dart';
import 'package:galaxy_music/signup.dart';

class LoginChoicePage extends StatelessWidget {
  const LoginChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  Positioned(
                    top: 200,
                    left: -3, 
                    bottom:0,
                    child: Image.asset(
                      'assets/imgbg/maskot nb 1 1.png', // Adjust path to your asset
                      width: 400,
                      height: 400,
                    ),
                  ),
                  const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 120),
                        Text(
                          'Ready to Explore?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Log In or Sign Up',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,
                    'Sign Up',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(), // Halaman SignUp
                        ),
                      );
                    },
                  ),
                  _buildButton(
                    context,
                    'Log In',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(), // Halaman LogIn
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Setel warna latar belakang
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

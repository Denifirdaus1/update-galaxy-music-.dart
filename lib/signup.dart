import 'package:flutter/material.dart';
import 'package:galaxy_music/cogratulation.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController untuk menangani teks input
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            _buildInputField('Name', nameController),
            const SizedBox(height: 20),
            _buildInputField('Email', emailController),
            const SizedBox(height: 20),
            _buildInputField('Password', passwordController, isPassword: true),
            const SizedBox(height: 20),
            _buildInputField('Confirm Password', confirmPasswordController,
                isPassword: true),
            const SizedBox(height: 40),
            _buildSignUpButton(context, nameController, emailController,
                passwordController, confirmPasswordController),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat input field
  Widget _buildInputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword, // Menyembunyikan teks untuk password
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol Sign Up
  Widget _buildSignUpButton(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    return ElevatedButton(
      onPressed: () {
        // Validasi data
        if (nameController.text.isEmpty ||
            emailController.text.isEmpty ||
            passwordController.text.isEmpty ||
            confirmPasswordController.text.isEmpty) {
          // Tampilkan dialog error jika ada field kosong
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Please fill in all fields'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Menutup dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if (passwordController.text !=
            confirmPasswordController.text) {
          // Tampilkan dialog error jika password tidak cocok
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Passwords do not match'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Menutup dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Jika validasi berhasil, navigasi ke halaman Congratulation
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const CongratulationPage()), // Ganti dengan halaman tujuan
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Setel warna latar belakang
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}

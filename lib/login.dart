import 'package:flutter/material.dart';
import 'package:galaxy_music/cogratulation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController untuk menangani teks input
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            _buildInputField('Gmail', emailController),
            const SizedBox(height: 20),
            _buildInputField('Password', passwordController, isPassword: true),
            const SizedBox(height: 40),
            _buildLoginButton(context, emailController, passwordController),
            const SizedBox(height: 40),
            _buildSocialLogin(),
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

  // Fungsi untuk membuat tombol login
  Widget _buildLoginButton(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return ElevatedButton(
      onPressed: () {
        // Simulasi login (cek validasi jika perlu)
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          // Jika login berhasil, navigasi ke halaman berikutnya
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const CongratulationPage()), // Ganti dengan halaman tujuan
          ); // Gantilah '/home' dengan nama rute yang sesuai
        } else {
          // Tampilkan dialog error jika login gagal
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Please enter both email and password'),
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
        'Log in',
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  // Fungsi untuk membuat tombol sosial login
  Widget _buildSocialLogin() {
    return Column(
      children: [
        const Text(
          'Continue with',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton('G'),
            const SizedBox(width: 20),
            _buildSocialButton('F'),
            const SizedBox(width: 20),
            _buildSocialButton('W'),
          ],
        ),
      ],
    );
  }

  // Fungsi untuk tombol sosial login (misal: Google, Facebook, dll.)
  Widget _buildSocialButton(String label) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}

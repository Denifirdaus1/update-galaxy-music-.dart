import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:galaxy_music/cogratulation.dart';
import 'package:galaxy_music/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        print("Attempting login with email: ${_emailController.text}");
        final response = await ApiService().login(
          _emailController.text,
          _passwordController.text,
        );

        print("Login successful: ${response['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CongratulationPage()),
        );
      } catch (e) {
        print("Login failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildTextField(String hint,
      {required TextEditingController controller, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromARGB(255, 116, 108, 108),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hint is required";
        }
        if (hint == "Email" &&
            !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
          return "Enter a valid email";
        }
        if (hint == "Password" && value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 165),
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 50),
                _buildTextField(
                  "Email",
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  "Password",
                  controller: _passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 140),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Colors.purple,
                          elevation: 5,
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  ),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

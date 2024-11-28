import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://07f2-114-79-54-169.ngrok-free.app/api";

  /// Fungsi untuk registrasi
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http
        .post(
          Uri.parse("$baseUrl/register"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 10)); // Tambahkan timeout

    print("Request to $baseUrl/register: {name: $name, email: $email}");
    print("Response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        throw Exception("Register failed: ${errorBody['message']}");
      } catch (_) {
        throw Exception("Register failed with status: ${response.statusCode}");
      }
    }
  }

  /// Fungsi untuk login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http
        .post(
          Uri.parse("$baseUrl/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
        )
        .timeout(const Duration(seconds: 10)); // Tambahkan timeout

    print("Request to $baseUrl/login: {email: $email}");
    print("Response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        throw Exception("Login failed: ${errorBody['message']}");
      } catch (_) {
        throw Exception("Login failed with status: ${response.statusCode}");
      }
    }
  }

  searchSongs(String query) {}

  fetchSongs() {}

  toggleFavorite(String id) {}

  deleteSong(String id) {}
}

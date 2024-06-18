import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl =
      'http://localhost:3000'; // Sesuaikan dengan URL backend Anda

  // Method untuk login dengan role
  static Future<http.Response> login(
      role, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  /* ADMIN */
  // Method Fetch
  static Future<List<dynamic>> get(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/hewan');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
        body: json.encode({
          'tableName': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception('Failed to fetch hewan: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to fetch hewan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching hewan: $e');
    }
  }

  // Method CREATE
  static Future<http.Response> postHewan(
      String token, String action, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'action': action, 'data': data}),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create hewan: $e');
    }
  }

  /* Admin */
  static Future<Map<String, dynamic>> fetchPemilik(int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/pemilik/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception('Failed to fetch pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching pemilik: $e');
    }
  }
}

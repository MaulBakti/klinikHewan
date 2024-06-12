import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl =
      'http://localhost:3000'; // Sesuaikan dengan URL backend Anda

  // Method untuk login dengan role

  static Future<http.Response> login(
      String role, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$role/login'),
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
  static Future<List<dynamic>> fetchHewan() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/hewan'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'action': 'read', // Add the action key with value "read"
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Check if the response contains the 'data' field
        if (responseData.containsKey('data')) {
          return responseData['data'] as List<dynamic>;
        } else {
          throw Exception('Data field not found in API response');
        }
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to fetch hewan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching hewan: $e');
    }
  }

  // Method CREATE
  static Future<http.Response> createHewan(
      Map<String, dynamic> hewanData, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(hewanData),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create hewan: $e');
    }
  }

  // Method GET
  static Future<http.Response> detailHewan(
      Map<String, dynamic> hewanData, String token) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/admin/hewan'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Menambahkan header authorization
      });

      return response;
    } catch (e) {
      throw Exception('Failed to create hewan: $e');
    }
  }
}

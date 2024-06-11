import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl =
      'http://localhost:3000'; // Sesuaikan dengan URL backend Anda

  // Method untuk login admin
  static Future<http.Response> adminLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Method untuk login pegawai
  static Future<http.Response> pegawaiLogin(
      String nama_pegawai, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama_pegawai': nama_pegawai,
          'password': password,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Method untuk login pegawai
  static Future<http.Response> pemilikLogin(
      String nama_pemilik, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pemilik/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nama_pemilik': nama_pemilik,
          'password': password,
        }),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  /* ADMIN */
  // Method CREATE
  static Future<http.Response> createHewan(
      Map<String, dynamic> hewanData, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
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

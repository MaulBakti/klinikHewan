import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:klinik_hewan/app/modules/Pemilik/model/pemilik.dart';

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
  // Method GET
  static Future<List<dynamic>> getHewanAdmin(String token) async {
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
          throw Exception(
              'Failed to get data hewan from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get hewan from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data hewan from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postHewanAdmin(
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
      throw Exception('Failed to create hewan from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getHewanAdminById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/hewan/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data hewan from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data hewan from Admin by ID: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteHewanAdmin(int id, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/admin/hewan/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to delete data hewan from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data hewan from Admin: $e');
    }
  }

  /* PEGAWAI */
  // Method GET
  static Future<List<dynamic>> getHewanPegawai(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/hewan');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
        body: json.encode({
          'tableName': 'pegawai',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data hewan from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get data hewan from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data hewan from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postHewanPegawai(
      String token, String action, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'action': action, 'data': data}),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data hewan from Admin:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getHewanPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/hewan/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data hewan from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data hewan from Pegawai by ID: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteHewanPegawai(int id, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/pegawai/hewan/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to delete data hewan from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data hewan from Pegawai: $e');
    }
  }

  /* PEMILIK */
  // Method GET
  static Future<List<dynamic>> getHewanPemilik(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/hewan');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Menambahkan header authorization
        },
        body: json.encode({
          'tableName': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch hewan from Pemilik: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch hewan from Pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching hewan from Pemilik: $e');
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

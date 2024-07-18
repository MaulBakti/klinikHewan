import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://localhost:3000';

  // Method untuk login dengan role
  static Future<http.Response> login(
      String role, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$role/login/'),
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

// Register Pemilik
  static Future<http.Response> register(
      String username, String password, String alamat, String notelp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pemilik/register/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'jabatan': 'pemilik', // jabatan sudah didefinisi secara default
          'alamat': alamat,
          'no_telp': notelp,
        }),
      );

      // Periksa status kode HTTP untuk penanganan error dasar
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  //HEWAN
  /* ADMIN */
  // Method GET
  static Future<List<dynamic>> getHewanAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/hewan');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print('GET Hewan Admin - Response status: ${response.statusCode}');
      print('GET Hewan Admin - Response body: ${response.body}');

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
      String token, Map<String, dynamic> hewanData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data': hewanData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
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
          'Authorization': 'Bearer $token',
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

  // Method PUT
  static Future<http.Response> updateHewanAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/hewan/${data['id_hewan']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Hewan Admin - Response status: ${response.statusCode}');
      print('Update Hewan Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data hewan from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update hewan from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating hewan: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteHewanAdmin(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_hewan": id},
        }),
      );

      print('Delete Hewan - Response status: ${response.statusCode}');
      print('Delete Hewan - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
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
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
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
              'Failed to fetch hewan from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch hewan from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching hewan from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postHewanPegawai(
      String token, Map<String, dynamic> hewanData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data': hewanData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data hewan from Pegawai:  $e');
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
          'Authorization': 'Bearer $token',
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

  // Method PUT
  static Future<http.Response> updateHewanPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/hewan/${data['id_hewan']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Hewan Pegawai - Response status: ${response.statusCode}');
      print('Update Hewan Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data hewan from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update hewan from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating hewan from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteHewanPegawai(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/hewan'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_hewan": id},
        }),
      );

      print('Delete Hewan - Response status: ${response.statusCode}');
      print('Delete Hewan - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
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
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/hewan');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
  //HEWAN CLOSE

  /*
  Doctor Admin
  */
  //Method GET
  static Future<List<dynamic>> getDoctorAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/doctor');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print('GET Doctor Admin - Response status: ${response.statusCode}');
      print('GET Doctor Admin - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data doctor from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get doctor from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data doctor from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postDoctorAdmin(
      String token, Map<String, dynamic> doctorData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/doctor'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data': doctorData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create doctor from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getDoctorAdminById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/doctor/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data doctor from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data doctor from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateDoctorAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/doctor/${data['id_doctor']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Doctor Admin - Response status: ${response.statusCode}');
      print('Update Doctor Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data Doctor from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update doctor from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating doctor: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteDoctorAdmin(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/doctor'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_dokter": id},
        }),
      );

      print('Delete Doctor - Response status: ${response.statusCode}');
      print('Delete Doctor - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data doctor from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data doctor from Admin: $e');
    }
  }

  /* PEGAWAI */
  // Method GET
  static Future<List<dynamic>> getDoctorPegawai(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/doctor');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('GET Doctor Pegawai - Response status: ${response.statusCode}');
      print('GET Doctor Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch doctor from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch doctor from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching doctor from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postDoctorPegawai(
      String token, Map<String, dynamic> doctorData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/doctor'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data': doctorData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data doctor from Pegawai:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getDoctorPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/doctor/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data doctor from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data doctor from Pegawai by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateDoctorPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/doctor/${data['id_doctor']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Doctor Pegawai - Response status: ${response.statusCode}');
      print('Update Doctor Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data doctor from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update doctor from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating doctor from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteDoctorPegawai(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/doctor'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_dokter": id},
        }),
      );

      print('Delete Doctor - Response status: ${response.statusCode}');
      print('Delete Doctor - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data doctor from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data doctor from Pegawai: $e');
    }
  }

  /* PEMILIK */
  // Method GET
  static Future<List<dynamic>> getDoctorPemilik(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/doctor');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch dokter from Pemilik: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch dokter from Pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching dokter from Pemilik: $e');
    }
  }

  /*
  Data Pegawai (Admin)
  */
  //Method GET
  static Future<List<dynamic>> getPegawaiAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/pegawai');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print('GET Pegawai Admin - Response status: ${response.statusCode}');
      print('GET Pegawai Admin - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data pegawai from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get pegawai from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pegawai from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postPegawaiAdmin(
      String token, Map<String, dynamic> pegawaiData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/pegawai'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data': pegawaiData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create pegawai from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<http.Response> getPegawaiAdminById(String token, int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/pegawai/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to get data pegawai from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pegawai from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updatePegawaiAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/pegawai/${data['id_pegawai']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Pegawai Admin - Response status: ${response.statusCode}');
      print('Update Pegawai Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data Pegawai from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update pegawai from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deletePegawaiAdmin(String token, int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/pegawai/:id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": id,
        }),
      );

      print('Delete Pegawai - Response status: ${response.statusCode}');
      print('Delete Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data pegawai from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data pegawai from Admin: $e');
    }
  }

  /*
  Data Pegawai (Pegawai)
  */
  // Method GET BY ID
  static Future<http.Response> getPegawaiPegawaiById(
      String token, int id) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/pegawai/pegawai/$id'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: json.encode({
                'role': 'pegawai',
                'action': 'read',
                'data': id, // Sesuaikan dengan data yang diperlukan jika ada
              }));
      if (response.statusCode != 200) {
        throw Exception('Failed to get pegawai: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      throw Exception('Error getting pegawai: $e');
    }
  }

  static Future<http.Response> updatePegawaiPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/pegawai/pegawai/${data['id_pegawai']}');
      final response = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            'role': 'pegawai',
            'action': 'update',
            'data': data, // Sesuaikan dengan data yang diperlukan jika ada
          }));
      if (response.statusCode != 200) {
        throw Exception('Failed to update pegawai: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      throw Exception('Error updating pegawai: $e');
    }
  }

  /*
  Data Pemilik (Admin)
  */
  // Method GET
  static Future<List<dynamic>> getPemilikAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/pemilik');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print('GET Pemilik Admin - Response status: ${response.statusCode}');
      print('GET Pemilik Admin - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data pemilik from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get pemilik from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pemilik from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postPemilikAdmin(
      String token, Map<String, dynamic> pemilikData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/pemilik'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data': pemilikData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create pemilik from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getPemilikAdminById(
      int id, String token) async {
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
        throw Exception(
            'Failed to get data pemilik from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pemilik from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updatePemilikAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/pemilik/${data['id_pemilik']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Pemilik Admin - Response status: ${response.statusCode}');
      print('Update Pemilik Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data pemilik from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update pemilik from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating pemilik: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deletePemilikAdmin(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/pemilik'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_pemilik": id},
        }),
      );

      print('Delete Pemilik - Response status: ${response.statusCode}');
      print('Delete Pemilik - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data pemilik from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data pemilik from Admin: $e');
    }
  }

  /*
  Pemilik Pegawai
  */
  // Method GET
  static Future<List<dynamic>> getPemilikPegawai(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/pemilik');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
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
              'Failed to fetch pemilik from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch pemilik from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching pemilik from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postPemilikPegawai(
      String token, Map<String, dynamic> pemilikData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/pemilik'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data': pemilikData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data pemilik from Pegawai:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getPemilikPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/pemilik/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data pemilik from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pemilik from Pegawai by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updatePemilikPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/pegawai/pemilik/${data['id_pemilik']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Pemilik Pegawai - Response status: ${response.statusCode}');
      print('Update Pemilik Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data pemilik from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update pemilik from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating pemilik from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deletePemilikPegawai(
      int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/pemilik'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_pemilik": id},
        }),
      );

      print('Delete pemilik - Response status: ${response.statusCode}');
      print('Delete Pemilik - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data pemilik from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data pemilik from Pegawai: $e');
    }
  }

  // Method GET BY ID
  static Future<http.Response> getPemilikPemilikById(
      String token, int id) async {
    try {
      final response =
          await http.post(Uri.parse('$baseUrl/pemilik/pemilik/$id'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: json.encode({
                'role': 'pemilik',
                'action': 'read',
                'data': id, // Sesuaikan dengan data yang diperlukan jika ada
              }));
      if (response.statusCode != 200) {
        throw Exception('Failed to get pemilik: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      throw Exception('Error getting pemilik: $e');
    }
  }

  // update Pemilik Pemilik
  static Future<http.Response> updatePemilikPemilik(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/pemilik/pemilik/${data['id_pemilik']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Pemilik  - Response status: ${response.statusCode}');
      print('Update Pemilik  - Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update pemilik: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      throw Exception('Error updating pemilik: $e');
    }
  }

  /*
  Obat Admin
  */
  // Method GET
  static Future<List<dynamic>> getObatAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/obat');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('GET Obat Admin: ${response.statusCode}');
      print('GET Obat Admin: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch obat from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch obat from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching obat from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postObatAdmin(
      String token, Map<String, dynamic> obatData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/obat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data': obatData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create obat from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getObatAdminById(
      int id, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/admin/obat/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data obat from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data obat from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateObatAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/obat/${data['id_obat']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Obat Admin - Response status: ${response.statusCode}');
      print('Update Obat Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data Obat from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update Obat from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating obat: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteObatAdmin(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/obat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_obat": id},
        }),
      );

      print('Delete Obat - Response status: ${response.statusCode}');
      print('Delete Obat - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data obat from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data obat from Admin: $e');
    }
  }

  /*
  Obat Pegawai
  */
  // Method GET
  static Future<List<dynamic>> getObatPegawai(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/obat');
      print('Using token: $token');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
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
              'Failed to fetch obat from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch obat from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching obat from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postObatPegawai(
      String token, Map<String, dynamic> obatData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/obat'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data': obatData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data obat from Pegawai:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getObatPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/obat/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data obat from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data obat from Pegawai by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateObatPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/obat/${data['id_obat']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Obat Pegawai - Response status: ${response.statusCode}');
      print('Update Obat Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data obat from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update obat from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating obat from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteObatPegawai(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/pegawai'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_obat": id},
        }),
      );

      print('Delete Obat - Response status: ${response.statusCode}');
      print('Delete Obat - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data obat from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data obat from Pegawai: $e');
    }
  }

  /*
  Obat Pemilik
  */
  // Method GET
  static Future<List<dynamic>> getObatPemilik(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/obat');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch obat from Pemilik: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch obat from Pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching obat from Pemilik: $e');
    }
  }

  /*
  Resep Admin
  */
  // Method GET
  static Future<List<dynamic>> getResepAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/resep');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('GET Resep Admin - Response status: ${response.statusCode}');
      print('GET Resep Admin - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Parsed response data: $responseData');

        if (responseData['success'] == 'read') {
          print('Read operation successful: ${responseData['data']}');
          return responseData['data'];
        } else {
          print(
              'Read operation failed with message: ${responseData['message']}');
          throw Exception(
              'Failed to get data resep from Admin: ${responseData['message']}');
        }
      } else {
        print('Request failed with status code: ${response.statusCode}');
        throw Exception(
            'Failed to get resep from Admin: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Error get data resep from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postResepAdmin(
      String token, Map<String, dynamic> resepData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/resep'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data': resepData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create resep from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getResepAdminById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/resep/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data resep from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data resep from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateResepAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/resep/${data['id_resep']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data,
        }),
      );

      print('Update Resep Admin - Response status: ${response.statusCode}');
      print('Update Resep Admin - Response body: ${response.body}');

      // Periksa status respons
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == 'update') {
          return response; // Berhasil
        } else {
          throw Exception(
              'Update failed: ${responseData['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to update resep: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating resep: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteResepAdmin(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/resep'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_resep": id},
        }),
      );

      print('Delete Resep - Response status: ${response.statusCode}');
      print('Delete Resep - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data resep from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data resep from Admin: $e');
    }
  }

  /* PEGAWAI */
  // Method GET
  static Future<List<dynamic>> getResepPegawai(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/resep');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
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
              'Failed to fetch resep from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch resep from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching resep from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postResepPegawai(
      String token, Map<String, dynamic> resepData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/resep'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data': resepData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data resep from Pegawai:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getResepPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/resep/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data resep from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data resep from Pegawai by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateResepPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/resep/${data['id_resep']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Update Resep Pegawai - Response status: ${response.statusCode}');
      print('Update Resep Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data resep from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update resep from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating resep from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteResepPegawai(int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/resep'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_resep": id},
        }),
      );

      print('Delete Resep - Response status: ${response.statusCode}');
      print('Delete Resep - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data resep from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data resep from Pegawai: $e');
    }
  }

  /* PEMILIK */
  // Method GET
  static Future<List<dynamic>> getResepPemilik(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/resep');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch resep from Pemilik: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch resep from Pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching resep from Pemilik: $e');
    }
  }
  //RESEP CLOSE

  /*
  Rekam Medis Admin
  */
  // Method GET
  static Future<List<dynamic>> getRekamMedisAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/rekammedis');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print('GET Rekam Medis Admin - Response status: ${response.statusCode}');
      print('GET Rekam Medis Admin - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data rekam medis from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get rekam medis from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data rekam medis from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postRekamMedisAdmin(
      String token, Map<String, dynamic> rekammedisData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/rekammedis'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data':
              rekammedisData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create rekammedis from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getRekamMedisAdminById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/rekammedis/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data rekammedis from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data rekammedis from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateRekamMedisAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/admin/rekammedis/${data['id_rekammedis']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print(
          'Update rekammedis Admin - Response status: ${response.statusCode}');
      print('Update rekammedis Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data rekammedis from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update rekammedis from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating rekammedis: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteRekamMedisAdmin(
      int id, String token) async {
    print('rekamedis: $id');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/rekammedis'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_rekammedis": id},
        }),
      );

      print('Delete rekammedis - Response status: ${response.statusCode}');
      print('Delete rekammedis - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data rekammedis from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data rekammedis from Admin: $e');
    }
  }

  /* PEGAWAI */
  // Method GET
  static Future<List<dynamic>> getRekamMedisPegawai(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/rekammedis');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
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
              'Failed to fetch rekammedis from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch rekammedis from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching rekammedis from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postRekamMedisPegawai(
      String token, Map<String, dynamic> rekammedisData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/rekammedis'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data':
              rekammedisData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data rekammedis from Pegawai:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getRekamMedisPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/rekammedis/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data rekammedis from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data rekammedis from Pegawai by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateRekamMedisPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/pegawai/rekammedis/${data['id_rekammedis']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print(
          'Update rekammedis Pegawai - Response status: ${response.statusCode}');
      print('Update rekammedis Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data rekammedis from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update rekammedis from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating rekammedis from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteRekamMedisPegawai(
      int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/rekammedis'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_rekammedis": id},
        }),
      );

      print('Delete rekammedis - Response status: ${response.statusCode}');
      print('Delete rekammedis - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data rekammedis from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data rekammedis from Pegawai: $e');
    }
  }

  /* PEMILIK */
  // Method GET
  static Future<List<dynamic>> getRekamMedisPemilik(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/rekammedis');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch rekammedis from Pemilik: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch rekammedis from Pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching rekammedis from Pemilik: $e');
    }
  }
  //REKAMMEDIS CLOSE

  //APPOINTMENT
  /* ADMIN */
  // Method GET
  static Future<List<dynamic>> getAppointmentAdmin(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/admin/appointment');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print('GET Appointment Admin - Response status: ${response.statusCode}');
      print('GET Appointment Admin - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data appointment from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get appointment from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data appointment from Admin: $e');
    }
  }

  // Method POST
  static Future<http.Response> postAppointmentAdmin(
      String token, Map<String, dynamic> appointmentData) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/appointment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'create',
          'data':
              appointmentData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create appointment from Admin: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getAppointmentAdminById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/appointment/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data appointment from Admin by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data appointment from Admin by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateAppointmentAdmin(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/admin/appointment/${data['id_appointment']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'admin',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print(
          'Update Appointment Admin - Response status: ${response.statusCode}');
      print('Update Appointment Admin - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data appointment from Admin: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update appointment from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating appointment: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteAppointmentAdmin(
      int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/appointment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "admin",
          "action": "delete",
          "data": {"id_appointment": id},
        }),
      );

      print('Delete Appointment - Response status: ${response.statusCode}');
      print('Delete Appointment - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data appointment from Admin: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data appointment from Admin: $e');
    }
  }

  /* PEGAWAI */
  // Method GET
  static Future<List<dynamic>> getAppointmentPegawai(String token) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/pegawai/appointment');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
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
              'Failed to fetch appointment from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch appointment from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointment from Pegawai: $e');
    }
  }

  // Method POST
  static Future<http.Response> postAppointmentPegawai(
      String token, Map<String, dynamic> appointmentData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/appointment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'create',
          'data':
              appointmentData, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create data appointment from Pegawai:  $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getAppointmentPegawaiById(
      int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pegawai/appointment/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data appointment from Pegawai by ID: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data appointment from Pegawai by ID: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updateAppointmentPegawai(
      String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/pegawai/appointment/${data['id_appointment']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pegawai',
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print(
          'Update Appointment Pegawai - Response status: ${response.statusCode}');
      print('Update Appointment Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data appointment from Pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update appointment from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating appointment from Pegawai: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deleteAppointmentPegawai(
      int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pegawai/appointment'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": "pegawai",
          "action": "delete",
          "data": {"id_appointment": id},
        }),
      );

      print('Delete Appointment - Response status: ${response.statusCode}');
      print('Delete Appointment - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data appointment from Pegawai: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data appointment from Pegawai: $e');
    }
  }

  /* PEMILIK */
  // Method GET
  static Future<List<dynamic>> getAppointmentPemilik(String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/pemilik/appointment');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': 'pemilik',
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to fetch appointment from Pemilik: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch appointment from Pemilik: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching appointment from Pemilik: $e');
    }
  }
  //APPOINTMENT CLOSE

  /*Pembayaran*/
  // Method GET
  static Future<http.Response> getPembayaran(String role, String token) async {
    print('Token available: $token');
    try {
      final Uri uri = Uri.parse('$baseUrl/$role/hewan');
      print('Using token: $token');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': role,
          'action': 'read',
          'data': {} // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      print(
          'GET Pembayaran by ${role} - Response status: ${response.statusCode}');
      print('GET Pembayaran by ${role} - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception(
              'Failed to get data pembayaran from ${role}: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to get data pembayaran from ${role}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pembayaran from ${role}: $e');
    }
  }

  // Method POST
  static Future<http.Response> postPembayaran(
      String role, String token, Map<String, dynamic> data) async {
    print('Token available: $token');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$role/pembayaran'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': role,
          'action': 'create',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create pembayaran from ${role}: $e');
    }
  }

  // Method GET BY ID
  static Future<Map<String, dynamic>> getPembayaranById(
      String role, int id, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$role/pembayaran/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception(
            'Failed to get data pembayaran by ID from ${role}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get data pembayaran by ID from ${role}: $e');
    }
  }

  // Method PUT
  static Future<http.Response> updatePembayaran(
      String role, String token, Map<String, dynamic> data) async {
    try {
      final Uri uri =
          Uri.parse('$baseUrl/$role/pembayaran/${data['id_pembayaran']}');

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'role': role,
          'action': 'update',
          'data': data, // Sesuaikan dengan data yang diperlukan jika ada
        }),
      );

      print(
          'Update Pembayaran by ${role} - Response status: ${response.statusCode}');
      print('Update Pembayaran by ${role} - Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return response;
        } else {
          throw Exception(
              'Failed to update data pembayaran from ${role}: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to update data pembayaran from ${role}: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating data pembayaran from ${role}: $e');
    }
  }

  // Method Delete
  static Future<http.Response> deletePembayaran(
      String role, int id, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$role/pembayaran'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "role": role,
          "action": "delete",
          "data": {"id_pembayaran": id},
        }),
      );

      print(
          'Delete Pembayaran by ${role} - Response status: ${response.statusCode}');
      print('Delete Pembayaran by ${role} - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            'Failed to delete data pembayaran from ${role} : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error delete data pembayaran from ${role} : $e');
    }
  }
}

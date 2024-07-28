import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '../../../data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:klinik_hewan/app/modules/Pembayaran/model/pembayaran.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Dokter/model/dokter.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';
import 'package:klinik_hewan/app/modules/Resep/model/resep.dart';

class pembayaranController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedPemilik = ''.obs;
  var selectedHewan = ''.obs;
  var selectedDokter = ''.obs;
  var selectedAppointment = ''.obs;
  var selectedRekamMedis = ''.obs;
  var selectedObat = ''.obs;
  var selectedResep = ''.obs;
  var pembayaranList = <Pembayaran>[].obs;
  var pemilikList = <Pemilik>[].obs;
  var hewanList = <Hewan>[].obs;
  var dokterList = <Dokter>[].obs;
  var appointmentList = <Appointment>[].obs;
  var rekammedisList = <rekamMedis>[].obs;
  var obatList = <Obat>[].obs;
  var resepList = <Resep>[].obs;

  var role = 'admin'.obs;

  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    print('Initializing Pembayaran Controller');
    getRole().then((value) {
      if (value != null) {
        role.value = value;
      }
    });
  }

  Future<String?> getToken() async {
    final token = box.read('token');
    print('Token retrieved: $token');
    return token;
  }

  Future<String?> getRole() async {
    final role = box.read('role');
    return role;
  }

  void clearToken() {
    box.remove('token');
    print('Token removed');
  }

  // Data Pemilik
  Future<void> getDataPemilik(String role) async {
    role = box.read('role');
    print('Fetching data pemilik for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getPemilikAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getPemilikPegawai(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Response data: $responseData');

      final List<Pemilik> pemiliks =
          responseData.map((data) => Pemilik.fromJson(data)).toList();
      pemilikList.assignAll(pemiliks);
      print('List pemilik: $pemilikList');
    } catch (e) {
      errorMessage.value = 'Error fetching data pemilik: $e';
      print('Error fetching data pemilik: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Data Hewan
  Future<void> getDataHewan(String role, String idPemilik) async {
    role = box.read('role');
    print('Fetching data hewan for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getHewanAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getHewanPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getHewanPemilik(token, idPemilik);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List hewan: $hewanList');

      final List<Hewan> hewans =
          responseData.map((data) => Hewan.fromJson(data)).toList();
      hewanList.assignAll(hewans);
      print('List hewan: $hewanList');
    } catch (e) {
      errorMessage.value = 'Error fetching data hewan: $e';
      print('Error fetching data hewan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Data Dokter
  Future<void> getDataDokter(String role) async {
    role = box.read('role');
    print('Fetching data Dokter for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getDokterAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getDokterPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getDokterPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List Dokter: $dokterList');

      final List<Dokter> dokters =
          responseData.map((data) => Dokter.fromJson(data)).toList();
      dokterList.assignAll(dokters);
      print('List Dokter: $dokterList');
    } catch (e) {
      errorMessage.value = 'Error fetching data Dokter: $e';
      print('Error fetching data Dokter: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Data Appointment
  Future<void> getDataAppoinment(String role) async {
    role = box.read('role');
    print('Fetching data hewan for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getAppointmentAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getAppointmentPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getAppointmentPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List Appointment: $appointmentList');

      final List<Appointment> appointments =
          responseData.map((data) => Appointment.fromJson(data)).toList();
      appointmentList.assignAll(appointments);
      print('List Appointment: $appointmentList');
    } catch (e) {
      errorMessage.value = 'Error fetching data appointments: $e';
      print('Error fetching data appointments: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Data Rekam Medis
  Future<void> getDataRekamMedis(String role) async {
    String role = box.read('role');
    print('Fetching data rekam medis for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getRekamMedisAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getRekamMedisPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getRekamMedisPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      final List<rekamMedis> rekammedisList =
          responseData.map((data) => rekamMedis.fromJson(data)).toList();
      rekammedisList.assignAll(rekammedisList);
      print('List Rekam Medis: $rekammedisList');
    } catch (e) {
      errorMessage.value = 'Error fetching data rekam medis: $e';
      print('Error fetching data rekam medis: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Data Obat
  Future<void> getDataObat(String role) async {
    role = box.read('role');
    print('Fetching data obat for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getObatAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getObatPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getObatPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List Rekam Medis: $obatList');

      final List<Obat> obat =
          responseData.map((data) => Obat.fromJson(data)).toList();
      obatList.assignAll(obat);
      print('List Obat: $obatList');
    } catch (e) {
      errorMessage.value = 'Error fetching data obat: $e';
      print('Error fetching data obat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Data Obat
  Future<void> getDataResep(String role) async {
    role = box.read('role');
    print('Fetching data obat for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getResepAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getResepPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getResepPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List Resep: $resepList');

      final List<Resep> resep =
          responseData.map((data) => Resep.fromJson(data)).toList();
      resepList.assignAll(resep);
      print('List Resep: $resepList');
    } catch (e) {
      errorMessage.value = 'Error fetching data resep: $e';
      print('Error fetching data resep: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk mengambil semua pembayaran
  Future<void> getDataPembayaran(String role, String token) async {
    print('Fetching data pembayaran for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        return;
      }

      final response = await ApiService.getPembayaran(role, token);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          final List<Pembayaran> pembayarans =
              (jsonResponse['data'] as List<dynamic>)
                  .map((data) => Pembayaran.fromJson(data))
                  .toList();
          pembayaranList.assignAll(pembayarans);
        } else {
          errorMessage.value = jsonResponse['message'];
        }
      } else {
        errorMessage.value = 'Error fetching data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching data pembayaran: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk menambahkan pembayaran
  Future<void> CreatePembayaran(
      String role, String token, Pembayaran pembayaran) async {
    try {
      final response =
          await ApiService.postPembayaran(role, token, pembayaran.toJson());
      if (response.statusCode == 200) {
        // Tambahkan pembayaran ke dalam data jika berhasil
        pembayaranList.add(Pembayaran.fromJson(
            json.decode(response.body))); // Pastikan response.body di-decode
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Pembayaran Create successfully',
        );
      }
    } catch (e) {
      print('Error creating pembayaran: $e');
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to create Pembayaran: $e',
      );
    }
  }

  // Method untuk memperbarui pembayaran
  Future<void> updatePembayaran(
      String role, String token, Pembayaran pembayaran) async {
    try {
      final response =
          await ApiService.updatePembayaran(role, token, pembayaran.toJson());
      if (response.statusCode == 200) {
        // Update pembayaran dalam data jika berhasil
        int index = pembayaranList
            .indexWhere((item) => item.idPembayaran == pembayaran.idPembayaran);
        if (index != -1) {
          pembayaranList[index] = Pembayaran.fromJson(json
              .decode(response.body)); // Update objek pembayaran di dalam list
        }
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Pembayaran Update successfully',
        );
      }
    } catch (e) {
      print('Error updating pembayaran: $e');
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to update Pembayaran: $e',
      );
    }
  }

  // Method untuk menghapus pembayaran
  Future<void> deletePembayaran(String role, int id, String token) async {
    try {
      final response = await ApiService.deletePembayaran(role, id, token);
      if (response.statusCode == 200) {
        // Hapus pembayaran dari list jika berhasil
        pembayaranList
            .removeWhere((item) => item.idPembayaran == id.toString());
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Pembayaran deleted successfully',
        );
      }
    } catch (e) {
      print('Error deleting pembayaran: $e');
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to delete Pembayaran: $e',
      );
    }
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '../../../data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:klinik_hewan/app/modules/Pembayaran/model/pembayaran.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';
import 'package:klinik_hewan/app/modules/Resep/model/resep.dart';

class pembayaranController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedPemilik = ''.obs;
  var selectedHewan = ''.obs;
  var selectedDoctor = ''.obs;
  var selectedAppointment = ''.obs;
  var selectedRekamMedis = ''.obs;
  var selectedObat = ''.obs;
  var selectedResep = ''.obs;
  var pembayaranList = <Pembayaran>[].obs;
  var pemilikList = <Pemilik>[].obs;
  var hewanList = <Hewan>[].obs;
  var doctorList = <Doctor>[].obs;
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
        // } else if (role == 'pemilik') {
        //   responseData = await ApiService.getPemilikPemilik(token);
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
  Future<void> getDataHewan(String role) async {
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
        responseData = await ApiService.getHewanPemilik(token);
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

  // Data Doctor
  Future<void> getDataDoctor(String role) async {
    role = box.read('role');
    print('Fetching data doctor for role: $role');
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
        responseData = await ApiService.getDoctorAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getDoctorPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getDoctorPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List Doctor: $doctorList');

      final List<Doctor> doctors =
          responseData.map((data) => Doctor.fromJson(data)).toList();
      doctorList.assignAll(doctors);
      print('List Doctor: $doctorList');
    } catch (e) {
      errorMessage.value = 'Error fetching data doctor: $e';
      print('Error fetching data doctor: $e');
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
      }
    } catch (e) {
      print('Error creating pembayaran: $e');
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
      }
    } catch (e) {
      print('Error updating pembayaran: $e');
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
      }
    } catch (e) {
      print('Error deleting pembayaran: $e');
    }
  }
}

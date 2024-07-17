import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '../model/pembayaran.dart';
import '../../../data/providers/api_service.dart';

class pembayaranController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var pembayaranList = <Pembayaran>[].obs;
  final box = GetStorage();
  var role = 'admin'.obs;

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
          final List<Pembayaran> pembayarans = (jsonResponse['data'] as List)
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

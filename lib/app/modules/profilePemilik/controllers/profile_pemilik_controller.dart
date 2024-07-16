import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Pemilik/models/pemilik.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';

class ProfilePemilikController extends GetxController {
  //TODO: Implement
  var isLoading = false.obs;
  var pemilikList = <Pemilik>[].obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  var role = ''.obs; // Menggunakan Rx<String> untuk menyimpan satu role
  var pemilik = Rx<Pemilik?>(null);

  @override
  void onInit() async {
    super.onInit();
    print('Initializing profileController');
    role.value = await getRole() ?? '';

    // Misalnya, ambil ID pegawai dari penyimpanan atau parameter
    int pemilikUd = 1; // Ganti dengan ID yang sesuai
    await getPemilikById(pemilikUd); // Ambil data pegawai
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

  Future<void> getPemilikById(int id) async {
    final currentRole = role.value;
    print('Fetching data pemilik for role: $currentRole');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');

      http.Response response =
          await ApiService.getPemilikPemilikById(token, id);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] is List) {
          // Jika data adalah array, ambil elemen pertama
          final pemilik = Pemilik.fromJson(responseData['data'][0]);
          this.pemilik.value = pemilik; // Simpan data pegawai
        } else {
          final pemilik = Pemilik.fromJson(responseData['data']);
          this.pemilik.value = pemilik; // Simpan data pegawai
        }
      } else {
        errorMessage.value = 'pemilik not found';
        print('Error: pemilik not found, Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Error fetching data pemilik: $e';
      print('Error fetching data pemilik: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePemilik(Pemilik updatedPemilik) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null) {
        errorMessage.value = 'Token not found';
        return;
      }

      final data =
          updatedPemilik.toJson(); // Assuming you have a toJson() method
      http.Response response =
          await ApiService.updatePemilikPemilik(token, data);
      if (response.statusCode == 200) {
        Get.defaultDialog(
          title: 'Success',
          middleText: 'pemilik updated successfully',
        );
      } else {
        Get.defaultDialog(
          title: 'Error',
          middleText: 'Failed to update pemilik: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Error updating pemilik: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

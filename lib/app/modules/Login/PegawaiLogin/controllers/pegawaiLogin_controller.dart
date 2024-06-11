import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';

class PegawailoginController extends GetxController {
  var nama_pegawai = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  void pegawaiLogin() async {
    if (nama_pegawai.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;

      try {
        final response =
            await ApiService.pegawaiLogin(nama_pegawai.value, password.value);

        isLoading.value = false;

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          // Simpan token atau data user lainnya jika diperlukan
          // Contoh: final token = data['token'];

          Get.snackbar('Login', 'Login successful');
          Get.offAllNamed('/pegawaihome'); // Navigasi ke halaman home
        } else {
          Get.snackbar('Error', 'Login failed: ${response.body}');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      Get.snackbar('Error', 'Please enter email and password');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

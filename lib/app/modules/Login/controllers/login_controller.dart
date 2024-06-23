import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var selectedRole = 'admin'.obs;
  var isLoading = false.obs;
  final box = GetStorage();

  void login(String role) async {
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;

      try {
        final response =
            await ApiService.login(role, username.value, password.value);

        isLoading.value = false;

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final token = data['data']['token'];

          // Menyimpan token ke storage
          GetStorage().write('token', token);

          Get.snackbar('Login', 'Login successful');

          if (role == 'admin') {
            Get.offAllNamed('/home');
          } else if (role == 'pegawai') {
            Get.offAllNamed('/home');
          } else if (role == 'pemilik') {
            Get.offAllNamed('/home');
          }
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      Get.snackbar('Error', 'Please enter username and password');
    }
  }

  void logout() {
    GetStorage().remove('token');
    // Lainnya seperti membersihkan username, password, dan role jika diperlukan
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

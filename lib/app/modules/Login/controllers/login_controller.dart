import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart'; // For local storage

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  // var isPasswordVisible = false.obs; // Definisikan isPasswordVisible
  var selectedRole = 'admin'.obs;
  var isLoading = false.obs;

  // void togglePasswordVisibility() {
  //   isPasswordVisible.value = !isPasswordVisible.value;
  // }

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
            Get.offAllNamed('/adminhome');
          } else if (role == 'pegawai') {
            Get.offAllNamed('/pegawaihome');
          } else if (role == 'pemilik') {
            Get.offAllNamed('/pemilikhome');
          }
        } else {
          Get.snackbar(
              'Error', 'Please enter username, password, and select a role');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      Get.snackbar('Error', 'Please enter username and password');
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

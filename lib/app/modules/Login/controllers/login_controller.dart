import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
<<<<<<< HEAD
=======
import 'package:klinik_hewan/app/modules/home/controllers/home_controller.dart'; // Import HomeController
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
<<<<<<< HEAD
  var selectedRole = 'admin'.obs;
=======
  var selectedRole = ''.obs;
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
  var isLoading = false.obs;
  final box = GetStorage();

  void login(String role) async {
<<<<<<< HEAD
    String role = selectedRole.value;
    print('Attempting to login with role: $role, username: $username');
    box.write('role', role);
=======
    // String role = selectedRole.value;
    print(
        'Attempting to login with role: ${selectedRole.value}, username: ${username.value}');
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;
      print(
          'Attempting to login with role: $role, username: ${username.value}, password: ${password.value}');
      try {
<<<<<<< HEAD
        final response =
            await ApiService.login(role, username.value, password.value);
=======
        final response = await ApiService.login(
            selectedRole.value, username.value, password.value);
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867

        print('Login response status: ${response.statusCode}');
        print('Login response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success']) {
            final token = data['data']['token'];
            print('Token received: $token');

            // Menyimpan token ke storage
            box.write('token', token);
            print('Token saved: ${box.read('token')}');

            Get.snackbar('Login', 'Login successful');
            print('Using token: $token');

<<<<<<< HEAD
            if (role == 'admin') {
              Get.offAllNamed('/home');
            } else if (role == 'pegawai') {
              Get.offAllNamed('/home');
            } else if (role == 'pemilik') {
              Get.offAllNamed('/home');
            }
=======
            // if (role == 'admin') {
            //   Get.offAllNamed('/home');
            // } else if (role == 'pegawai') {
            //   Get.offAllNamed('/home');
            // } else if (role == 'pemilik') {
            //   Get.offAllNamed('/home');
            // }
            // Update role in HomeController
            Get.find<HomeController>().changeRole(selectedRole.value);

            // Navigate to home page
            Get.offAllNamed('/home');
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
          } else {
            Get.snackbar('Error', 'Failed to login');
          }
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      } catch (e) {
        print('Login error: $e');
        Get.snackbar('Error', 'An error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Please enter username and password');
    }
  }

  void logout() {
    box.remove('token');
    print('Token removed on logout');
    // Lainnya seperti membersihkan username, password, dan role jika diperlukan
  }

  Future<String?> getToken() async {
    final token = box.read('token');
    print('Token retrieved: $token');
    return token;
  }

<<<<<<< HEAD
  Future<String?> getRole() async {
    final role = box.read('role');
    print('Token retrieved: $role');
    return role;
  }

=======
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
  void clearToken() {
    box.remove('token');
    print('Token removed');
  }

  @override
  void onInit() {
    super.onInit();
    print('LoginController initialized');
  }

  @override
  void onReady() {
    super.onReady();
    print('LoginController is ready');
  }

  @override
  void onClose() {
    super.onClose();
    print('LoginController closed');
  }
}

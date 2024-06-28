import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/modules/home/controllers/home_controller.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  final box = GetStorage();

  void login() async {
    final role = selectedRole.value;
    print('Attempting to login with role: $role, username: ${username.value}');

    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;
      print(
          'Logging in with role: $role, username: ${username.value}, password: ${password.value}');
      try {
        final response =
            await ApiService.login(role, username.value, password.value);

        print('Login response status: ${response.statusCode}');
        print('Login response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success']) {
            final token = data['data']['token'];
            print('Token received: $token');

            // Save token and role to storage
            box.write('token', token);
            box.write('role', role);
            print(
                'Token and role saved: ${box.read('token')}, ${box.read('role')}');

            Get.snackbar('Login', 'Login successful');
            print('Using token: $token');

            // Update role in HomeController
            Get.find<HomeController>().changeRole();

            // Navigate to home page
            Get.offAllNamed('/home');
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
    box.remove('role');
    print('Token and role removed on logout');
    // Additional cleanup if necessary
  }

  Future<String?> getToken() async {
    final token = box.read('token');
    print('Token retrieved: $token');
    return token;
  }

  Future<String?> getRole() async {
    final role = box.read('role');
    print('Role retrieved: $role');
    return role;
  }

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

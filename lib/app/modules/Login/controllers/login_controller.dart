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

  void login() async {
    String role = selectedRole.value;
    box.write('role', role);
    print('Attempting to login with role: $role, username: ${username.value}');
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;
      print(
          'Attempting to login with role: $role, username: ${username.value}, password: ${password.value}');
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

            // Menyimpan token ke storage
            box.write('token', token);
            print('Token saved: ${box.read('token')}');

            Get.defaultDialog(
              title: 'Login',
              middleText: 'Login successful',
            );
            print('Using token: $token');

            Future.delayed(Duration(seconds: 2), () {
              if (role == 'admin') {
                Get.offAllNamed('/home');
              } else if (role == 'pegawai') {
                Get.offAllNamed('/home');
              } else if (role == 'pemilik') {
                Get.offAllNamed('/home');
              }
            });
          } else {
            Get.defaultDialog(
              title: 'Error',
              middleText: 'Failed to login',
            );
          }
        } else {
          Get.defaultDialog(
            title: 'Error',
            middleText: 'Incorrect username and password',
          );
        }
      } catch (e) {
        print('Login error: $e');
        Get.defaultDialog(
          title: 'Error',
          middleText: 'An error occurred: $e',
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Please enter username and password',
      );
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

  Future<String?> getRole() async {
    final role = box.read('role');
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

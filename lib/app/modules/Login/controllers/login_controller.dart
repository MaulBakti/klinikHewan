import 'package:flutter/material.dart';
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
      print('Attempting to login...');

      try {
        final response =
            await ApiService.login(role, username.value, password.value);
        print('Login response status: ${response.statusCode}');
        print('Login response body: ${response.body}');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success']) {
            final token = data['data']['token'];
            final idPemilik =
                data['data']['id_pemilik']; // Ambil ID pemilik dari respons
            print('Token received: $token');

            // Menyimpan token dan ID pemilik ke storage
            box.write('token', token);
            box.write('id', idPemilik); // Simpan ID pemilik
            print('Token saved: ${box.read('token')}');
            print('ID pemilik saved: ${box.read('id')}');

            Get.defaultDialog(
              backgroundColor: Colors.green,
              titleStyle: TextStyle(color: Colors.white),
              middleTextStyle: TextStyle(color: Colors.white),
              title: 'Login',
              middleText: 'Login $role successful',
            );

            Future.delayed(Duration(seconds: 2), () {
              if (role == 'admin') {
                Get.offAllNamed('/home');
              } else if (role == 'pegawai') {
                Get.offAllNamed('/home');
              } else if (role == 'pemilik') {
                Get.offAllNamed('/pemilikhome');
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
            backgroundColor: Colors.red,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
            title: 'Error',
            middleText: 'Incorrect username and password',
          );
        }
      } catch (e) {
        print('Login error: $e');
        Get.defaultDialog(
          backgroundColor: Colors.red,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Error',
          middleText: 'An error occurred: $e',
        );
      } finally {
        isLoading.value = false;
        print('Loading state set to false');
      }
    } else {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Please enter username and password',
      );
    }
  }

  void logout() {
    box.remove('token');
    box.remove('id'); // Hapus ID pemilik saat logout
    print('Token and ID removed on logout');
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

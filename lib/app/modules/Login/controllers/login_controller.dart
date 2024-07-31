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
            print('Token received: $token');
            box.write('token', token); // Simpan token
            print('Token saved: ${box.read('token')}');

            Get.defaultDialog(
              backgroundColor: Colors.green,
              titleStyle: TextStyle(color: Colors.white),
              middleTextStyle: TextStyle(color: Colors.white),
              title: 'Login',
              middleText: 'Login $role successful',
            );

            Future.delayed(Duration(seconds: 2), () {
              if (role == 'pemilik') {
                Get.offAllNamed('/pemilikhome');
              } else if (role == 'admin') {
                Get.offAllNamed('/home');
              } else if (role == 'pegawai') {
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
}

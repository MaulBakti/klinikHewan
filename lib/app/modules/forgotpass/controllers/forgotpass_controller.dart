import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_service.dart';

class ForgotpassController extends GetxController {
  var usernameOrTelp = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void resetPassword() async {
    if (usernameOrTelp.value.isEmpty) {
      Get.snackbar('Error', 'Username/Telephone is required');
      return;
    }

    if (newPassword.value.isEmpty) {
      Get.snackbar('Error', 'New Password is required');
      return;
    }

    if (confirmPassword.value.isEmpty) {
      Get.snackbar('Error', 'Confirm Password is required');
      return;
    }

    if (newPassword.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      final response = await ApiService.Forgotpass(
        usernameOrTelp.value,
        newPassword.value,
      );

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      if (response.statusCode == 200) {
        // Registration successful, handle accordingly
        print('Registration successful');
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Register',
          middleText: 'Register successful',
        );
      } else {
        // Registration failed, show error message
        print('Registration failed');
        Get.defaultDialog(
          backgroundColor: Colors.red,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Register',
          middleText: 'Register Failed',
        );
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Regist',
        middleText: 'Regist error: $error',
      );
    }
  }
}

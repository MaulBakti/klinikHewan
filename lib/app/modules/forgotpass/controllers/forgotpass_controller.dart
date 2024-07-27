import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_service.dart';

class ForgotpassController extends GetxController {
  var keywords = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void resetPassword() async {
    if (keywords.value.isEmpty) {
      Get.snackbar('Error', 'Username or Telephone is required');
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
      print(
          'Resetting password for username: ${keywords.value}, notelp: ${keywords.value}');
      final response = await ApiService.forgotPass(
        keywords.value.isNotEmpty ? keywords.value : null,
        newPassword.value,
      );

      print('Forgot pass response status: ${response.statusCode}');
      print('Forgot pass response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Reset Password',
          middleText: 'Password successfully updated',
        );
      } else {
        Get.defaultDialog(
          backgroundColor: Colors.red,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Error',
          middleText: responseData['message'] ?? 'Failed to forgot password',
        );
      }
    } catch (error) {
      print('Error: $error');
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Error: $error',
      );
    }
  }
}

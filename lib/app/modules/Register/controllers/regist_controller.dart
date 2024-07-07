import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_service.dart';

class RegistController extends GetxController {
  //TODO: Implement RegistController
  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var alamat = ''.obs;
  var noTelp = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void register() async {
    try {
      final response = await ApiService.regist(
        username.value,
        password.value,
        alamat.value,
        noTelp.value,
      );

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      if (response.statusCode == 200) {
        // Registration successful, handle accordingly
        print('Registration successful');
        Get.defaultDialog(
          title: 'Regist',
          middleText: 'Regist successful',
        );
      } else {
        // Registration failed, show error message
        print('Registration failed');
        Get.defaultDialog(
          title: 'Regist',
          middleText: 'Regist Failed',
        );
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      Get.defaultDialog(
        title: 'Regist',
        middleText: 'Regist error: $error',
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

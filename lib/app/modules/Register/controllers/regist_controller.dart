import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class RegistController extends GetxController {
  //TODO: Implement RegistController
  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var jabatan = ''.obs;
  var alamat = ''.obs;
  var noTelp = ''.obs;
  final box = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void register() async {
    try {
      final response = await ApiService.register(
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
          title: 'Register',
          middleText: 'Register successful',
        );
      } else {
        // Registration failed, show error message
        print('Registration failed');
        Get.defaultDialog(
          title: 'Register',
          middleText: 'Register Failed',
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

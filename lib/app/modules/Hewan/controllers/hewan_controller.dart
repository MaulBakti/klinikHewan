import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';

class HewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> createHewan(Map<String, dynamic> hewanData, String token) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService.createHewan(hewanData, token);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Hewan berhasil ditambahkan');
      } else {
        errorMessage.value = response.body.toString();
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

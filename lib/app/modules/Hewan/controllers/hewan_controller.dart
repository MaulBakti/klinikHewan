// hewan_controller.dart
import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/services/local_storage_service.dart';
import 'dart:convert';

class HewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var hewanList = <Hewan>[].obs;

  Future<void> fetchDataHewan(String role) async {
    isLoading.value = true;
    errorMessage.value = '';
    final LocalStorageService storageService = LocalStorageService();

    try {
      final String? token = storageService.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final responseData = await ApiService.fetchHewan(token);
      final List<Hewan> hewans =
          responseData.map((data) => Hewan.fromJson(data)).toList();
      hewanList.assignAll(hewans);
    } catch (e) {
      errorMessage.value = 'Error fetching hewan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createHewan(String role, Hewan hewan) async {
    try {
      final LocalStorageService storageService = LocalStorageService();
      final String? token = storageService.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response =
          await ApiService.postHewan(token, 'create', hewan.toJson());
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdHewan = Hewan.fromJson(responseData['data']);
        hewanList.add(createdHewan);
        Get.snackbar('Success', 'Hewan created successfully');
      } else {
        throw Exception('Failed to create hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create hewan: $e');
    }
  }

  Future<void> updateHewan(String role, Hewan hewan) async {
    try {
      final LocalStorageService storageService = LocalStorageService();
      final String? token = storageService.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response =
          await ApiService.postHewan(token, 'update', hewan.toJson());
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedHewan = Hewan.fromJson(responseData['data']);
        int index = hewanList
            .indexWhere((element) => element.idHewan == updatedHewan.idHewan);
        if (index != -1) {
          hewanList[index] = updatedHewan;
        }
        Get.snackbar('Success', 'Hewan updated successfully');
      } else {
        throw Exception('Failed to update hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update hewan: $e');
    }
  }

  Future<void> deleteHewan(String role, int idHewan) async {
    try {
      final LocalStorageService storageService = LocalStorageService();
      final String? token = storageService.getToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response =
          await ApiService.postHewan(token, 'delete', {'id_hewan': idHewan});
      if (response.statusCode == 200) {
        hewanList.removeWhere((element) => element.idHewan == idHewan);
        Get.snackbar('Success', 'Hewan deleted successfully');
      } else {
        throw Exception('Failed to delete hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete hewan: $e');
    }
  }
}

// hewan_controller.dart
import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/services/local_storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var hewanList = <Hewan>[].obs;
  final LocalStorageService storageService = LocalStorageService();
  late String token;

  @override
  void onInit() {
    super.onInit();
    token = storageService.getToken() ?? '';
    if (token.isEmpty) {
      errorMessage.value = 'Token not found';
      isLoading.value = false;
    }
  }

  Future<void> getDataHewan(String role) async {
    if (token.isEmpty) {
      errorMessage.value = 'Token not found';
      isLoading.value = false;
      return;
    }

    try {
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getHewanAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getHewanPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getHewanPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      final List<Hewan> hewans =
          responseData.map((data) => Hewan.fromJson(data)).toList();
      hewanList.assignAll(hewans);
    } catch (e) {
      errorMessage.value = 'Error fetching data hewan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataHewan(String role, Hewan hewan, String token) async {
    try {
      if (token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }

      http.Response response;

      if (role == 'admin') {
        response =
            await ApiService.postHewanAdmin(token, 'create', hewan.toJson());
      } else if (role == 'pegawai') {
        response =
            await ApiService.postHewanPegawai(token, 'create', hewan.toJson());
      } else {
        throw Exception('Invalid role: $role');
      }
      // final response =
      //     await ApiService.postHewan(token, 'create', hewan.toJson());
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

  Future<void> updateHewan(String role, Hewan hewan, String token) async {
    try {
      if (token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }

      http.Response response;

      if (role == 'admin') {
        response =
            await ApiService.updateHewanAdmin(token, 'update', hewan.toJson());
        // Panggil ApiService untuk update hewan admin
      } else if (role == 'pegawai') {
        response = await ApiService.updateHewanPegawai(
            token, 'update', hewan.toJson());
      } else {
        throw Exception('Invalid role: $role');
      }

      // final response =
      //     await ApiService.postHewan(token, 'update', hewan.toJson());
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

  Future<void> deleteHewan(String role, int idHewan, String token) async {
    try {
      if (token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }

      http.Response response;

      if (role == 'admin') {
        response = await ApiService.deleteHewanAdmin(idHewan, token);
      } else if (role == 'pegawai') {
        response = await ApiService.postHewanPegawai(
            token, 'delete', {'id_hewan': idHewan});
      } else {
        throw Exception('Invalid role: $role');
      }
      // final response =
      //     await ApiService.postHewan(token, 'delete', {'id_hewan': idHewan});
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

  // Fungsi untuk fetch nama_pemilik berdasarkan id_pemilik
  Future<String> getNamaPemilik(int idPemilik, String token) async {
    try {
      var pemilik = await ApiService.fetchPemilik(idPemilik, token);
      return pemilik['username'] ?? '';
    } catch (e) {
      print('Error fetching pemilik: $e');
      return '';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var hewanList = <Hewan>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    print('Initializing HewanController');
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

  Future<void> getDataHewan() async {
    try {
      isLoading.value = true;
      final String? token = await getToken();
      final String? role = await getRole();

      if (token == null || token.isEmpty || role == null || role.isEmpty) {
        errorMessage.value = 'Token or role not found';
        isLoading.value = false;
        print('Error: Token or role not found');
        return;
      }

      List<dynamic> responseData;

      switch (role) {
        case 'admin':
          responseData = await ApiService.getHewanAdmin(token);
          break;
        case 'pegawai':
          responseData = await ApiService.getHewanPegawai(token);
          break;
        case 'pemilik':
          responseData = await ApiService.getHewanPemilik(token);
          break;
        default:
          throw Exception('Invalid role: $role');
      }

      final List<Hewan> hewans =
          responseData.map((data) => Hewan.fromJson(data)).toList();
      hewanList.assignAll(hewans);
    } catch (e) {
      errorMessage.value = 'Error fetching data hewan: $e';
      print('Error fetching data hewan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataHewan(Hewan hewan) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();
      final String? role = await getRole();

      if (token == null || token.isEmpty || role == null || role.isEmpty) {
        errorMessage.value = 'Token or role not found';
        isLoading.value = false;
        print('Error: Token or role not found');
        return;
      }

      http.Response response;

      switch (role) {
        case 'admin':
          response =
              await ApiService.postHewanAdmin(token, 'create', hewan.toJson());
          break;
        case 'pegawai':
          response = await ApiService.postHewanPegawai(
              token, 'create', hewan.toJson());
          break;
        default:
          throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdHewan = Hewan.fromJson(responseData['data']);
        hewanList.add(createdHewan);
        Get.snackbar('Success', 'Hewan created successfully');
      } else {
        throw Exception('Failed to create hewan: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to create hewan: $e';
      Get.snackbar('Error', 'Failed to create hewan: $e');
      print('Failed to create hewan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateHewan(Hewan hewan) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();
      final String? role = await getRole();

      if (token == null || token.isEmpty || role == null || role.isEmpty) {
        errorMessage.value = 'Token or role not found';
        isLoading.value = false;
        print('Error: Token or role not found');
        return;
      }

      http.Response response;

      switch (role) {
        case 'admin':
          response = await ApiService.updateHewanAdmin(
              token, 'update', hewan.toJson());
          break;
        case 'pegawai':
          response = await ApiService.updateHewanPegawai(
              token, 'update', hewan.toJson());
          break;
        default:
          throw Exception('Invalid role: $role');
      }

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
      errorMessage.value = 'Failed to update hewan: $e';
      Get.snackbar('Error', 'Failed to update hewan: $e');
      print('Failed to update hewan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHewan(int idHewan) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();
      final String? role = await getRole();

      if (token == null || token.isEmpty || role == null || role.isEmpty) {
        errorMessage.value = 'Token or role not found';
        isLoading.value = false;
        print('Error: Token or role not found');
        return;
      }

      http.Response response;

      switch (role) {
        case 'admin':
          response = await ApiService.deleteHewanAdmin(idHewan, token);
          break;
        case 'pegawai':
          response = await ApiService.deleteHewanPegawai(idHewan, token);
          break;
        default:
          throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        hewanList.removeWhere((element) => element.idHewan == idHewan);
        Get.snackbar('Success', 'Hewan deleted successfully');
      } else {
        throw Exception('Failed to delete hewan: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Failed to delete hewan: $e';
      Get.snackbar('Error', 'Failed to delete hewan: $e');
      print('Failed to delete hewan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
  // Future<String> getNamaPemilik(int idPemilik) async {
  //   try {
  //     isLoading.value = true;
  //     var pemilik = await ApiService.fetchPemilik(idPemilik, token);
  //     return pemilik['username'] ?? '';
  //   } catch (e) {
  //     print('Error fetching pemilik: $e');
  //     return '';
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

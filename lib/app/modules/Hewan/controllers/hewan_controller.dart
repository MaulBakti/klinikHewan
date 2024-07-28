import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  var hewanList = <Hewan>[].obs;
  var pemilikList = <Pemilik>[].obs;
  var role = 'admin'.obs;
  late String idPemilik;

  @override
  void onInit() {
    super.onInit();
    print('Initializing HewanController');
    getRole().then((value) {
      if (value != null) {
        role.value = value;
      }
    });
  }

  Future<String?> getToken() async {
    final token = box.read('token');
    print('Token retrieved: $token');
    return token;
  }

  Future<String?> getRole() async {
    final role = box.read('role');
    return role;
  }

  void clearToken() {
    box.remove('token');
    print('Token removed');
  }

  Future<void> getDataPemilik(String role) async {
    role = box.read('role');
    print('Fetching data pemilik for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getPemilikAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getPemilikPegawai(token);
        // } else if (role == 'pemilik') {
        //   responseData = await ApiService.getPemilikPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Response data: $responseData');

      final List<Pemilik> pemiliks =
          responseData.map((data) => Pemilik.fromJson(data)).toList();
      pemilikList.assignAll(pemiliks);
      print('List pemilik: $pemilikList');
    } catch (e) {
      errorMessage.value = 'Error fetching data pemilik: $e';
      print('Error fetching data pemilik: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDataHewan(String role, String idPemilik) async {
    role = box.read('role');
    print('Fetching data hewan for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Reset loading state
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getHewanAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getHewanPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getHewanPemilik(token, idPemilik);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List hewan: $hewanList');

      final List<Hewan> hewans =
          responseData.map((data) => Hewan.fromJson(data)).toList();
      hewanList.assignAll(hewans);
      print('List hewan: $hewanList');
    } catch (e) {
      errorMessage.value = 'Error fetching data hewan: $e';
      print('Error fetching data hewan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataHewan(Hewan hewan) async {
    final role = await getRole();
    print('Posting data hewan for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final hewanData = hewan.toJson();
      print('Data Hewan: $hewanData'); // Log data hewan yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postHewanAdmin(token, 'create', hewan.toJson());
        response = await ApiService.postHewanAdmin(token, hewanData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postHewanPegawai(token, 'create', hewan.toJson());
        response = await ApiService.postHewanPegawai(token, hewanData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Hewan - Response status: ${response.statusCode}');
      print('Create Hewan - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdHewan = Hewan.fromJson(responseData['data']);
        hewanList.add(createdHewan);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Hewan created successfully',
        );
      } else {
        throw Exception('Failed to create hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to create hewan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateHewan(Hewan hewan) async {
    final role = await getRole();
    print('Updating data hewan for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = hewan.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateHewanAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateHewanPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Hewan - Response status: ${response.statusCode}');
      print('Update Hewan - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedHewan = Hewan.fromJson(responseData['data']);
        int index = hewanList
            .indexWhere((element) => element.idHewan == updatedHewan.idHewan);
        if (index != -1) {
          hewanList[index] = updatedHewan;
        }
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Hewan updated successfully',
        );
      } else {
        throw Exception('Failed to update hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to update hewan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHewan(int idHewan) async {
    final role = await getRole();
    print('Deleting data hewan for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');

      http.Response response;

      if (role == 'admin') {
        response = await ApiService.deleteHewanAdmin(idHewan, token);
      } else if (role == 'pegawai') {
        response = await ApiService.deleteHewanPegawai(idHewan, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        hewanList.removeWhere((element) => element.idHewan == idHewan);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Hewan deleted successfully',
        );
      } else {
        throw Exception('Failed to delete hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to delete hewan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

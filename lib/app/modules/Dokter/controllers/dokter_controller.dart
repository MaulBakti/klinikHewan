import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Dokter/model/dokter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DokterController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var dokterList = <Dokter>[].obs;
  final box = GetStorage();
  var role = 'admin'.obs;

  @override
  void onInit() {
    super.onInit();
    print('Initializing DoctorController');
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

  Future<void> getDataDokter(String role) async {
    try {
      isLoading.value = true;
      role = box.read('role'); // Mengambil role dari GetStorage

      print('Fetching data doctor for role: $role');

      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getDokterAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getDokterPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getDokterPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      final List<Dokter> dokters =
          responseData.map((data) => Dokter.fromJson(data)).toList();
      dokterList.assignAll(dokters);
      print('List Dokter: $dokterList');
    } catch (e) {
      errorMessage.value = 'Error fetching data Dokter: $e';
      print('Error fetching data Dokter: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataDokter(Dokter dokter) async {
    final role = await getRole();
    print('Posting data Dokter for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final dokterData = dokter.toJson();
      print('Data Dokter: $dokterData'); // Log data doctor yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postDoctorAdmin(token, 'create', doctor.toJson());
        response = await ApiService.postDokterAdmin(token, dokterData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postDoctorPegawai(token, 'create', doctor.toJson());
        response = await ApiService.postDokterPegawai(token, dokterData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Dokter - Response status: ${response.statusCode}');
      print('Create Dokter - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdDokter = Dokter.fromJson(responseData['data']);
        dokterList.add(createdDokter);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Dokter created successfully',
        );
      } else {
        throw Exception('Failed to create Dokter: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to create Dokter: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateDokter(Dokter dokter) async {
    final role = await getRole();
    print('Updating data Dokter for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = dokter.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateDokterAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateDokterPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Dokter - Response status: ${response.statusCode}');
      print('Update Dokter - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedDokter = Dokter.fromJson(responseData['data']);
        int index = dokterList.indexWhere(
            (element) => element.idDokter == updatedDokter.idDokter);
        if (index != -1) {
          dokterList[index] = updatedDokter;
        }
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Dokter updated successfully',
        );
      } else {
        throw Exception('Failed to update Dokter: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to update Dokter: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDokter(int idDokter) async {
    final role = await getRole();
    print('Deleting data Dokter for role: $role');
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
        response = await ApiService.deleteDokterAdmin(idDokter, token);
      } else if (role == 'pegawai') {
        response = await ApiService.deleteDokterPegawai(idDokter, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        dokterList.removeWhere((element) => element.idDokter == idDokter);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Dokter deleted successfully',
        );
      } else {
        throw Exception('Failed to delete Dokter: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to delete Dokter: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

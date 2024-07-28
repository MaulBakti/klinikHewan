import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Resep/model/resep.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResepController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var resepList = <Resep>[].obs;
  final box = GetStorage();
  var role = 'admin'.obs;

  @override
  void onInit() {
    super.onInit();
    print('Initializing ResepController');
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

  Future<void> getDataResep(String role) async {
    role = box.read('role');
    print('Fetching data resep for role: $role');
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
        responseData = await ApiService.getResepAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getResepPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getResepPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List resep: $resepList');

      final List<Resep> reseps =
          responseData.map((data) => Resep.fromJson(data)).toList();
      resepList.assignAll(reseps);
      print('List resep: $resepList');
    } catch (e) {
      errorMessage.value = 'Error fetching data resep $role: $e';
      print('Error fetching data resep $role: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataResep(Resep resep) async {
    final role = await getRole();
    print('Posting data resep for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final resepData = resep.toJson();
      print('Data resep: $resepData'); // Log data resep yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postresepAdmin(token, 'create', resep.toJson());
        response = await ApiService.postResepAdmin(token, resepData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postresepPegawai(token, 'create', resep.toJson());
        response = await ApiService.postResepPegawai(token, resepData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Resep - Response status: ${response.statusCode}');
      print('Create Resep - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdResep = Resep.fromJson(responseData['data']);
        resepList.add(createdResep);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Resep created successfully',
        );
      } else {
        throw Exception('Failed to create resep: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to create resep: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateResep(Resep resep) async {
    final role = await getRole();
    print('Updating data resep for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = resep.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateResepAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateResepPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Resep - Response status: ${response.statusCode}');
      print('Update Resep - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedResep = Resep.fromJson(responseData['data']);
        int index = resepList
            .indexWhere((element) => element.idResep == updatedResep.idResep);
        if (index != -1) {
          resepList[index] = updatedResep; // Memperbarui item di list
        }
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Resep updated successfully',
        );
      } else {
        throw Exception('Failed to update resep: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to update resep: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteResep(int idResep) async {
    final role = await getRole();
    print('Deleting data resep for role: $role');
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
        response = await ApiService.deleteResepAdmin(idResep, token);
      } else if (role == 'pegawai') {
        response = await ApiService.deleteResepPegawai(idResep, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        resepList.removeWhere((element) => element.idResep == idResep);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Resep deleted successfully',
        );
      } else {
        throw Exception('Failed to delete resep: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to delete resep: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

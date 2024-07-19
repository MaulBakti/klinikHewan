import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';
import '../../../data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ObatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var obatList = <Obat>[].obs;
  final box = GetStorage();
  var role = 'admin'.obs;

  @override
  void onInit() {
    super.onInit();
    print('Initializing ObatController');
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

  Future<void> getDataObat(String role) async {
    role = box.read('role');
    print('Fetching data dooctor for role: $role');
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
        responseData = await ApiService.getObatAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getObatPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getObatPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List obat: $obatList');

      final List<Obat> obats =
          responseData.map((data) => Obat.fromJson(data)).toList();
      obatList.assignAll(obats);
      print('List obat: $obatList');
    } catch (e) {
      errorMessage.value = 'Error fetching data obat: $e';
      print('Error fetching data obat: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataObat(Obat obat) async {
    final role = await getRole();
    print('Posting data obat for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final obatData = obat.toJson();
      print('Data Obat: $obatData'); // Log data obat yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postobatAdmin(token, 'create', obat.toJson());
        response = await ApiService.postObatAdmin(token, obatData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postobatPegawai(token, 'create', obat.toJson());
        response = await ApiService.postObatPegawai(token, obatData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Obat - Response status: ${response.statusCode}');
      print('Create Obat - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdObat = Obat.fromJson(responseData['data']);
        obatList.add(createdObat);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Obat created successfully',
        );
      } else {
        throw Exception('Failed to create obat: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to create obat: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateObat(Obat obat) async {
    final role = await getRole();
    print('Updating data obat for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = obat.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateObatAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateObatPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Obat - Response status: ${response.statusCode}');
      print('Update Obat - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedObat = Obat.fromJson(responseData['data']);
        int index = obatList
            .indexWhere((element) => element.idObat == updatedObat.idObat);
        if (index != -1) {
          obatList[index] = updatedObat;
        }
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Obat updated successfully',
        );
      } else {
        throw Exception('Failed to update obat: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to update obat: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteObat(int idObat) async {
    final role = await getRole();
    print('Deleting data obat for role: $role');
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
        response = await ApiService.deleteObatAdmin(idObat, token);
      } else if (role == 'pegawai') {
        response = await ApiService.deleteObatPegawai(idObat, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        obatList.removeWhere((element) => element.idObat == idObat);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Obat deleted successfully',
        );
      } else {
        throw Exception('Failed to delete obat: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to delete obat: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

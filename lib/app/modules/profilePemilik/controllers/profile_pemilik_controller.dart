import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Pemilik/models/pemilik.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';

class ProfilePemilikController extends GetxController {
  var isLoading = false.obs;
  var pemilik = Rx<Pemilik?>(null);
  var errorMessage = ''.obs;
  final box = GetStorage();
  var role = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    print('Initializing ProfilePemilikController');
    role.value = await getRole() ?? '';

    // Assuming pemilikId is obtained from GetStorage or passed as a parameter
    int pemilikId = 1; // Replace with actual ID
    await getPemilikById(pemilikId);
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

  Future<void> getPemilikById(int id) async {
    print('Fetching data pemilik for ID: $id');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      http.Response response =
          await ApiService.getPemilikPemilikById(token, id);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] is List) {
          final pemilikData = Pemilik.fromJson(responseData['data'][0]);
          pemilik.value = pemilikData;
        } else {
          final pemilikData = Pemilik.fromJson(responseData['data']);
          pemilik.value = pemilikData;
        }
      } else {
        errorMessage.value = 'Pemilik not found';
        print('Error: Pemilik not found, Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Error fetching data pemilik: $e';
      print('Error fetching data pemilik: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePemilik(Pemilik updatedPemilik) async {
    print('Updating data pemilik');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null) {
        errorMessage.value = 'Token not found';
        return;
      }

      final data = updatedPemilik.toJson();
      http.Response response =
          await ApiService.updatePemilikPemilik(token, data);

      if (response.statusCode == 200) {
        final updatedData = Pemilik.fromJson(jsonDecode(response.body)['data']);
        pemilik.value = updatedData;

        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Pemilik updated successfully',
        );
      } else {
        Get.defaultDialog(
          backgroundColor: Colors.red,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Error',
          middleText: 'Failed to update pemilik: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Error updating pemilik: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

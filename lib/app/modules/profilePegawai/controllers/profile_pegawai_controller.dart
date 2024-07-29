import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Pegawai/models/pegawai.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';

class ProfilePegawaiController extends GetxController {
  var isLoading = false.obs;
  var pegawaiList = <Pegawai>[].obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  var role = ''.obs; // Menggunakan Rx<String> untuk menyimpan satu role
  var pegawai = Rx<Pegawai?>(null);

  @override
  void onInit() async {
    super.onInit();
    print('Initializing PegawaiController');
    role.value = await getRole() ?? '';

    // Misalnya, ambil ID pegawai dari penyimpanan atau parameter
    int pegawaiId = 1; // Ganti dengan ID yang sesuai
    await getPegawaiById(pegawaiId); // Ambil data pegawai
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

  Future<int?> getIdPegawai() async {
    final idPegawai = box.read('id');
    print('ID Pegawai retrieved: $idPegawai');
    return idPegawai;
  }

  void clearToken() {
    box.remove('token');
    print('Token removed');
  }

  Future<void> getPegawaiById(int id) async {
    final currentRole = role.value;
    print('Fetching data pegawai for role: $currentRole');
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
          await ApiService.getPegawaiPegawaiById(token, id);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] is List) {
          // Jika data adalah array, ambil elemen pertama
          final pegawai = Pegawai.fromJson(responseData['data'][0]);
          this.pegawai.value = pegawai; // Simpan data pegawai
        } else {
          final pegawai = Pegawai.fromJson(responseData['data']);
          this.pegawai.value = pegawai; // Simpan data pegawai
        }
      } else {
        errorMessage.value = 'Pegawai not found';
        print('Error: Pegawai not found, Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Error fetching data pegawai: $e';
      print('Error get data pegawai from pegawai: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePegawai(Pegawai updatedPegawai) async {
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null) {
        errorMessage.value = 'Token not found';
        return;
      }

      final data =
          updatedPegawai.toJson(); // Assuming you have a toJson() method
      http.Response response =
          await ApiService.updatePegawaiPegawai(token, data);
      if (response.statusCode == 200) {
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Pegawai updated successfully',
        );
      } else {
        Get.defaultDialog(
          backgroundColor: Colors.red,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Error',
          middleText: 'Failed to update pegawai: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Error updating pegawai: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

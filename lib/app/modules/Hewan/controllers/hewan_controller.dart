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
    return role;
  }

  void clearToken() {
    box.remove('token');
    print('Token removed');
  }

  Future<void> getDataHewan(String role) async {
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
        responseData = await ApiService.getHewanPemilik(token);
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
        Get.snackbar('Success', 'Hewan created successfully');
      } else {
        throw Exception('Failed to create hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create hewan: $e');
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
        Get.snackbar('Success', 'Hewan updated successfully');
      } else {
        throw Exception('Failed to update hewan: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update hewan: $e');
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
      Get.snackbar('Success', 'Hewan deleted successfully');
    } else {
      throw Exception('Failed to delete hewan: ${response.statusCode}');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to delete hewan: $e');
  } finally {
    isLoading.value = false;
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
}

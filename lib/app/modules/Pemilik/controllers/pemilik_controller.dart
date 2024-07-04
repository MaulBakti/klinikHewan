import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pemilik.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';

class PemilikController extends GetxController {
  //TODO: Implement PemilikController
  var isLoading = false.obs;
  var pemilikList = <Pemilik>[].obs;
  var errorMessage = ''.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    print('Initializing PemilikController');
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
        responseData = await ApiService.getPemilikAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getPemilikPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getPemilikPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List pemilik: $pemilikList');

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

  Future<void> postDataPemilik(Pemilik pemilik) async {
    final role = await getRole();
    print('Posting data pemilik for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final pemilikData = pemilik.toJson();
      print('Data pemilik: $pemilikData'); // Log data pemilik yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postpemilikAdmin(token, 'create', pemilik.toJson());
        response = await ApiService.postPemilikAdmin(token, pemilikData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postpegawaiPegawai(token, 'create', pegawai.toJson());
        response = await ApiService.postPemilikPegawai(token, pemilikData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Pemilik - Response status: ${response.statusCode}');
      print('Create Pemilik - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdPemilik = Pemilik.fromJson(responseData['data']);
        pemilikList.add(createdPemilik);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Pemilik created successfully',
        );
      } else {
        throw Exception('Failed to create pemilik: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to create pemilik: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePemilik(Pemilik pemilik) async {
    final role = await getRole();
    print('Updating data pemilik for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = pemilik.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updatePemilikAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updatePemilikPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Pemilik - Response status: ${response.statusCode}');
      print('Update Pemilik - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedPemilik = Pemilik.fromJson(responseData['data']);
        int index = pemilikList.indexWhere(
            (element) => element.idPemilik == updatedPemilik.idPemilik);
        if (index != -1) {
          pemilikList[index] = updatedPemilik;
        }
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Pemilik updated successfully',
        );
      } else {
        throw Exception('Failed to update pemilik: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to update pemilik: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePemilik(int idPemilik) async {
    final role = await getRole();
    print('Deleting data pemilik for role: $role');
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
        response = await ApiService.deletePemilikAdmin(idPemilik, token);
      } else if (role == 'pegawai') {
        response = await ApiService.deletePemilikPegawai(idPemilik, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        pemilikList.removeWhere((element) => element.idPemilik == idPemilik);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Pemilik deleted successfully',
        );
      } else {
        throw Exception('Failed to delete pemilik: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to delete pemilik: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

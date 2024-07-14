import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RekamMedisController extends GetxController {
  //TODO: Implement RekamMedisController
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selecteHewan = ''.obs;
  var rekammedisList = <rekamMedis>[].obs;
  var hewans = <dynamic>[
    {
      "id_hewan": "23",
      "nama_hewan": "kucing",
    },
    {
      "id_hewan": "24",
      "nama_hewan": "Anjing",
    }
  ].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    print('Initializing rekamMedisController');
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

  Future<void> getDataRekamMedis(String role) async {
    role = box.read('role');
    print('Fetching data rekamMedis for role: $role');
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
        responseData = await ApiService.getRekamMedisAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getRekamMedisPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getRekamMedisPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List RekamMedis: $rekammedisList');

      final List<rekamMedis> rekammediss =
          responseData.map((data) => rekamMedis.fromJson(data)).toList();
      rekammedisList.assignAll(rekammediss);
      print('List rekammedis: $rekammedisList');
    } catch (e) {
      errorMessage.value = 'Error fetching data rekammedis: $e';
      print('Error fetching data rekammedis: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataRekamMedis(rekamMedis rekammedis) async {
    final role = await getRole();
    print('Posting data rekammedis for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final rekammedisData = rekammedis.toJson();
      print(
          'Data rekamMedis: $rekammedisData'); // Log data rekammedis yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postrekammedisAdmin(token, 'create', rekammedis.toJson());
        response = await ApiService.postRekamMedisAdmin(token, rekammedisData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postrekammedisPegawai(token, 'create', rekammedis.toJson());
        response =
            await ApiService.postRekamMedisPegawai(token, rekammedisData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create rekammedis - Response status: ${response.statusCode}');
      print('Create rekammedis - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdrekammedis = rekamMedis.fromJson(responseData['data']);
        rekammedisList.add(createdrekammedis);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'rekammedis created successfully',
        );
      } else {
        throw Exception('Failed to create rekammedis: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to create rekammedis: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateRekamMedis(rekamMedis rekammedis) async {
    final role = await getRole();
    print('Updating data rekammedis for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = rekammedis.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateRekamMedisAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateRekamMedisPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update RekamMedis - Response status: ${response.statusCode}');
      print('Update RekamMedis - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedrekammedis = rekamMedis.fromJson(responseData['data']);
        int index = rekammedisList.indexWhere((element) =>
            element.idRekamMedis == updatedrekammedis.idRekamMedis);
        if (index != -1) {
          rekammedisList[index] = updatedrekammedis;
        }
        Get.defaultDialog(
          title: 'Success',
          middleText: 'rekammedis updated successfully',
        );
      } else {
        throw Exception('Failed to update rekammedis: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to update rekammedis: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteRekamMedis(int idrekammedis) async {
    final role = await getRole();
    print('Deleting data rekammedis for role: $role');
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
        response = await ApiService.deleteRekamMedisAdmin(idrekammedis, token);
      } else if (role == 'pegawai') {
        response =
            await ApiService.deleteRekamMedisPegawai(idrekammedis, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        rekammedisList
            .removeWhere((element) => element.idRekamMedis == idrekammedis);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'rekammedis deleted successfully',
        );
      } else {
        throw Exception('Failed to delete rekammedis: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to delete rekammedis: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

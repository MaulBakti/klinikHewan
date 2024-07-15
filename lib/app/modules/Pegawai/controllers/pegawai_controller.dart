import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pegawai.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';

class PegawaiController extends GetxController {
  var isLoading = false.obs;
  var pegawaiList = <Pegawai>[].obs;
  var errorMessage = ''.obs;
  final box = GetStorage();
  var role = 'admin'.obs;

  @override
  void onInit() {
    super.onInit();
    print('Initializing PegawaiController');
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

  Future<void> getDataPegawai(String role) async {
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
        responseData = await ApiService.getPegawaiAdmin(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List pegawai: $pegawaiList');

      final List<Pegawai> pegawais =
          responseData.map((data) => Pegawai.fromJson(data)).toList();
      pegawaiList.assignAll(pegawais);
      print('List pegawai: $pegawaiList');
    } catch (e) {
      errorMessage.value = 'Error fetching data pegawai: $e';
      print('Error fetching data pegawai: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataPegawai(Pegawai pegawai) async {
    final role = await getRole();
    print('Posting data pegawai for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final pegawaiData = pegawai.toJson();
      print('Data Pegawai: $pegawaiData'); // Log data pegawai yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postpegawaiAdmin(token, 'create', pegawai.toJson());
        response = await ApiService.postPegawaiAdmin(token, pegawaiData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Pegawai - Response status: ${response.statusCode}');
      print('Create Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdPegawai = Pegawai.fromJson(responseData['data']);
        pegawaiList.add(createdPegawai);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Pegawai created successfully',
        );
      } else {
        throw Exception('Failed to create pegawai: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to create pegawai: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePegawai(Pegawai pegawai) async {
    final role = await getRole();
    print('Updating data pegawai for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = pegawai.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updatePegawaiAdmin(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Pegawai - Response status: ${response.statusCode}');
      print('Update Pegawai - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedPegawai = Pegawai.fromJson(responseData['data']);
        int index = pegawaiList.indexWhere(
            (element) => element.idPegawai == updatedPegawai.idPegawai);
        if (index != -1) {
          pegawaiList[index] = updatedPegawai;
        }
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Pegawai updated successfully',
        );
      } else {
        throw Exception('Failed to update pegawai: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to update pegawai: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePegawai(int idPegawai) async {
    final role = await getRole();
    print('Deleting data pegawai for role: $role');
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
        response = await ApiService.deletePegawaiAdmin(idPegawai, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        pegawaiList.removeWhere((element) => element.idPegawai == idPegawai);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Pegawai deleted successfully',
        );
      } else {
        throw Exception('Failed to delete pegawai: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to delete pegawai: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

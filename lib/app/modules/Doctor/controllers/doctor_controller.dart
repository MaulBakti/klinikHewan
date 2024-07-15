import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var doctorList = <Doctor>[].obs;
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

  Future<void> getDataDoctor(String role) async {
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
        responseData = await ApiService.getDoctorAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getDoctorPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getDoctorPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      final List<Doctor> doctors =
          responseData.map((data) => Doctor.fromJson(data)).toList();
      doctorList.assignAll(doctors);
      print('List doctor: $doctorList');
    } catch (e) {
      errorMessage.value = 'Error fetching data doctor: $e';
      print('Error fetching data doctor: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataDoctor(Doctor doctor) async {
    final role = await getRole();
    print('Posting data doctor for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final doctorData = doctor.toJson();
      print('Data Doctor: $doctorData'); // Log data doctor yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postDoctorAdmin(token, 'create', doctor.toJson());
        response = await ApiService.postDoctorAdmin(token, doctorData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postDoctorPegawai(token, 'create', doctor.toJson());
        response = await ApiService.postDoctorPegawai(token, doctorData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Doctor - Response status: ${response.statusCode}');
      print('Create Doctor - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdDoctor = Doctor.fromJson(responseData['data']);
        doctorList.add(createdDoctor);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Doctor created successfully',
        );
      } else {
        throw Exception('Failed to create doctor: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to create doctor: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateDoctor(Doctor doctor) async {
    final role = await getRole();
    print('Updating data doctor for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = doctor.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateDoctorAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateDoctorPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Doctor - Response status: ${response.statusCode}');
      print('Update Doctor - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedDoctor = Doctor.fromJson(responseData['data']);
        int index = doctorList.indexWhere(
            (element) => element.idDokter == updatedDoctor.idDokter);
        if (index != -1) {
          doctorList[index] = updatedDoctor;
        }
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Doctor updated successfully',
        );
      } else {
        throw Exception('Failed to update doctor: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to update doctor: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDoctor(int idDoctor) async {
    final role = await getRole();
    print('Deleting data doctor for role: $role');
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
        response = await ApiService.deleteDoctorAdmin(idDoctor, token);
      } else if (role == 'pegawai') {
        response = await ApiService.deleteDoctorPegawai(idDoctor, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        doctorList.removeWhere((element) => element.idDokter == idDoctor);
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Doctor deleted successfully',
        );
      } else {
        throw Exception('Failed to delete doctor: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to delete doctor: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

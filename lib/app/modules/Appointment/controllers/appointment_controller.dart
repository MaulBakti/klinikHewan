import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:klinik_hewan/app/modules/Pemilik/models/pemilik.dart';
import 'package:klinik_hewan/app/modules/Hewan/models/hewan.dart';
import 'package:klinik_hewan/app/modules/Dokter/model/dokter.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedPemilik = ''.obs;
  var selectedHewan = ''.obs;
  var selectedDokter = ''.obs;
  var pemilikList = <Pemilik>[].obs;
  var hewanList = <Hewan>[].obs;
  var dokterList = <Dokter>[].obs;
  var appointmentList = <Appointment>[].obs;

  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    print('Initializing AppointmentController');
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

// Data Dokter
  Future<void> getDataDokter(String role) async {
    role = box.read('role');
    print('Fetching data dokter for role: $role');
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
        responseData = await ApiService.getDokterAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getDokterPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getDokterPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List Dokter: $dokterList');

      final List<Dokter> dokters =
          responseData.map((data) => Dokter.fromJson(data)).toList();
      dokterList.assignAll(dokters);
      print('List Dokter: $dokterList');
    } catch (e) {
      errorMessage.value = 'Error fetching data dokter: $e';
      print('Error fetching data dokter: $e');
    } finally {
      isLoading.value = false;
    }
  }

// Data Hewan
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

// Data Pemilik
  Future<void> getDataPemilik(String role) async {
    role = box.read('role');
    print('Fetching data pemilik for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getPemilikAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getPemilikPegawai(token);
        // } else if (role == 'pemilik') {
        //   responseData = await ApiService.getPemilikPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Response data: $responseData');

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

  Future<void> getDataAppointment(String role) async {
    role = box.read('role');
    print('Fetching data appointment for role: $role');
    try {
      isLoading.value = true;
      final String? token = await getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        print('Error: Token not found');
        return;
      }

      print('Using token: $token');
      List<dynamic> responseData;

      if (role == 'admin') {
        responseData = await ApiService.getAppointmentAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getAppointmentPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getAppointmentPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }

      final List<Appointment> appointments =
          responseData.map((data) => Appointment.fromJson(data)).toList();
      appointmentList.assignAll(appointments);
      print('List appointment: $appointmentList');
    } catch (e) {
      errorMessage.value = 'Error fetching data appointment: $e';
      print('Error fetching data appointment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postDataAppointment(Appointment appointment) async {
    final role = await getRole();
    print('Posting data appointment for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false; // Added to reset loading state
        return;
      }
      print('Token: $token');

      final appointmentData = appointment.toJson();
      print(
          'Data Appointment: $appointmentData'); // Log data appointment yang akan dikirim
      http.Response response;

      if (role == 'admin') {
        // response = await ApiService.postappointmentAdmin(token, 'create', appointment.toJson());
        response =
            await ApiService.postAppointmentAdmin(token, appointmentData);
      } else if (role == 'pegawai') {
        // response = await ApiService.postappointmentPegawai(token, 'create', appointment.toJson());
        response =
            await ApiService.postAppointmentPegawai(token, appointmentData);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Create Appointment - Response status: ${response.statusCode}');
      print('Create Appointment - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final createdAppointment = Appointment.fromJson(responseData['data']);
        appointmentList.add(createdAppointment);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Appointment created successfully',
        );
      } else {
        throw Exception('Failed to create appointment: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to create appointment: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAppointment(Appointment appointment) async {
    final role = await getRole();
    print('Updating data appointment for role: $role');
    try {
      isLoading.value = true;
      final String? token = GetStorage().read('token');
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Token not found';
        isLoading.value = false;
        return;
      }
      print('Token: $token');
      final data = appointment.toJson();
      http.Response response;

      if (role == 'admin') {
        response = await ApiService.updateAppointmentAdmin(token, data);
      } else if (role == 'pegawai') {
        response = await ApiService.updateAppointmentPegawai(token, data);
      } else {
        throw Exception('Invalid role: $role');
      }

      print('Update Appointment - Response status: ${response.statusCode}');
      print('Update Appointment - Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final updatedAppointment = Appointment.fromJson(responseData['data']);
        int index = appointmentList.indexWhere((element) =>
            element.idAppointment == updatedAppointment.idAppointment);
        if (index != -1) {
          appointmentList[index] = updatedAppointment;
        }
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Appointment updated successfully',
        );
      } else {
        throw Exception('Failed to update appointment: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to update appointment: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAppointment(int idAppointment) async {
    final role = await getRole();
    print('Deleting data appointment for role: $role');
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
        response =
            await ApiService.deleteAppointmentAdmin(idAppointment, token);
      } else if (role == 'pegawai') {
        response =
            await ApiService.deleteAppointmentPegawai(idAppointment, token);
      } else {
        throw Exception('Invalid role: $role');
      }

      if (response.statusCode == 200) {
        appointmentList
            .removeWhere((element) => element.idAppointment == idAppointment);
        Get.defaultDialog(
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          title: 'Success',
          middleText: 'Appointment deleted successfully',
        );
      } else {
        throw Exception('Failed to delete appointment: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        backgroundColor: Colors.red,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        title: 'Error',
        middleText: 'Failed to delete appointment: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

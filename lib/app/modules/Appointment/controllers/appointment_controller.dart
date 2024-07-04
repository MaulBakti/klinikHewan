import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
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

  Future<void> getDataAppointment(String role) async {
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
        responseData = await ApiService.getAppointmentAdmin(token);
      } else if (role == 'pegawai') {
        responseData = await ApiService.getAppointmentPegawai(token);
      } else if (role == 'pemilik') {
        responseData = await ApiService.getAppointmentPemilik(token);
      } else {
        throw Exception('Invalid role: $role');
      }
      print('List appointment: $appointmentList');

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
          title: 'Success',
          middleText: 'Appointment created successfully',
        );
      } else {
        throw Exception('Failed to create appointment: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
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
          title: 'Success',
          middleText: 'Appointment updated successfully',
        );
      } else {
        throw Exception('Failed to update appointment: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
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
          title: 'Success',
          middleText: 'Appointment deleted successfully',
        );
      } else {
        throw Exception('Failed to delete appointment: ${response.statusCode}');
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Failed to delete appointment: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}

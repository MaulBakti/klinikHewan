import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import '../models/hewan.dart'; // Import the Hewan model
import 'dart:convert';

class HewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var hewanList = <Hewan>[].obs; // Change the type to Hewan

  Future<void> fetchDataHewan() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final responseData = await ApiService.fetchHewan();
      // Map the fetched data to Hewan objects
      final List<Hewan> hewans =
          responseData.map((data) => Hewan.fromJson(data)).toList();
      // Update hewanList with the mapped data
      hewanList.assignAll(hewans);
    } catch (e) {
      errorMessage.value = 'Error fetching hewan: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';

class UbahhewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var nama = ''.obs;
  var jenis = ''.obs;
  var usia = ''.obs;
  var token = ''.obs;

  void updateHewan() async {}
}

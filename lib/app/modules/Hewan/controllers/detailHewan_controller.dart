import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';
import 'dart:convert';
import '../models/hewan.dart';

class DetailhewanController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var hewanList = <Hewan>[].obs;
}

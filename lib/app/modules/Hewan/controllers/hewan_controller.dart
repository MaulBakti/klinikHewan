import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HewanController extends GetxController {
  //TODO: Implement HewanController

  final count = 0.obs;
  var listData = [].obs;

  // void getData() {
  //   listData.clear();
  //   DataKlinikProvider().getAll().then((Response response) {
  //     final Map jsonResponse = response.body;
  //     jsonResponse.forEach((key, value) {
  //       listData.add(value);
  //       //isi data yang ditampilkan
  //     });
  //   });
  // }

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

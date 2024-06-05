import 'package:get/get.dart';
import '../model/pemilik.dart';

class PemilikController extends GetxController {
  //TODO: Implement PemilikController

  var data = <Pemilik>[].obs;


  void addPemilik(Pemilik pemilik) {
    data.add(pemilik);
  }

  void updatePemilik(String id_pemilik, Pemilik pemilik) {

  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}

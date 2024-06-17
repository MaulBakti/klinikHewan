import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/RekamMedis/model/rekamMedis.dart';

class TambahRekamMedisController extends GetxController {
  //TODO: Implement RekamMedisController

  var data = <rekamMedis>[].obs;

  void addrekamMedis(rekamMedis rekamMedis) {
    data.add(rekamMedis);
  }
  // final count = 0.obs;
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
  //
  // void increment() => count.value++;
}

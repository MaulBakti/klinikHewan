import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pegawai/model/pegawai.dart';

class PegawaiController extends GetxController {
  //TODO: Implement PegawaiController

  var data = <Pegawai>[].obs;


  void addPegawai(Pegawai pegawai) {
    data.add(pegawai);
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

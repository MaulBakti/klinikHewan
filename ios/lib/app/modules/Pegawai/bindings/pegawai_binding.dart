import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pegawai/controllers/pegawai_controller.dart';

class PegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PegawaiController>(() => PegawaiController());
  }
}

import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pegawai/controllers/ubahPegawai_controller.dart';

class UbahpegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahpegawaiController>(() => UbahpegawaiController());
  }
}

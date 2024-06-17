import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pegawai/controllers/detailPegawai_controller.dart';

class DetailpegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailpegawaiController>(() => DetailpegawaiController());
  }
}

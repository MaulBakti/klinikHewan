import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pegawai/controllers/tambahPegawai_controller.dart';

class TambahpegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahpegawaiController>(() => TambahpegawaiController());
  }
}

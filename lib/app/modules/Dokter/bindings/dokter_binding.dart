import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Dokter/controllers/dokter_controller.dart';

class DokterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterController>(() => DokterController());
  }
}

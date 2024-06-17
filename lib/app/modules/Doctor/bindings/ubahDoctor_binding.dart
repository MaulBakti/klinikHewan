import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/controllers/ubahDoctor_controller.dart';

class HewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahdoctorController>(() => UbahdoctorController());
  }
}

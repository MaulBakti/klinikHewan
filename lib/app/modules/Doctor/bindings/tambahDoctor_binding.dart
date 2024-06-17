import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/controllers/tambahDoctor_controller.dart';

class HewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahdoctorController>(() => TambahdoctorController());
  }
}

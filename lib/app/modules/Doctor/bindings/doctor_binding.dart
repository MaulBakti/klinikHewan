import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/controllers/doctor_controller.dart';

class DoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorController>(() => DoctorController());
  }
}

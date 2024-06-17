import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/controllers/detailDoctor_controller.dart';

class HewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetaildoctorController>(() => DetaildoctorController());
  }
}

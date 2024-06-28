import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';

class HewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HewanController>(() => HewanController());
  }
}

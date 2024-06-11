import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/ubahHewan_controller.dart';
import '../controllers/tambahHewan_controller.dart';

class UbahhewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahhewanController>(
      () => UbahhewanController(),
    );
  }
}

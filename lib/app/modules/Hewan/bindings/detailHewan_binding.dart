import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/detailHewan_controller.dart';
import 'package:klinik_hewan/app/modules/Hewan/controllers/hewan_controller.dart';

class DetailhewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailhewanController>(() => DetailhewanController());
  }
}

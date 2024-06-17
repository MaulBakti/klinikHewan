import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Obat/controllers/obat_controller.dart';

class ObatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObatController>(() => ObatController());
  }
}

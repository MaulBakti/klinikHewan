import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/resep/controllers/resep_controller.dart';

class ResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResepController>(() => ResepController());
  }
}

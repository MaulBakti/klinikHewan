import 'package:get/get.dart';

import '../controllers/ubahrekam_medis_controller.dart';

class UbahRekamMedisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahRekamMedisController>(
      () => UbahRekamMedisController(),
    );
  }
}

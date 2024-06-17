import 'package:get/get.dart';

import '../controllers/tambahrekam_medis_controller.dart';

class TambahRekamMedisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahRekamMedisController>(
      () => TambahRekamMedisController(),
    );
  }
}

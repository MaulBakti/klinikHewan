import 'package:get/get.dart';

import '../controllers/harga_controller.dart';

class HargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HargaController>(
      () => HargaController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/pegawaiHome_controller.dart';

class PegawaihomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PegawaihomeController>(
      () => PegawaihomeController(),
    );
  }
}

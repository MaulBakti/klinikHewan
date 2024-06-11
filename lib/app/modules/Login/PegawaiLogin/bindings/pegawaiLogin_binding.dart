import 'package:get/get.dart';

import '../controllers/pegawaiLogin_controller.dart';

class PegawailoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PegawailoginController>(
      () => PegawailoginController(),
    );
  }
}

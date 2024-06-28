import 'package:get/get.dart';

import '../controllers/pemilikPembayaran_controller.dart';

class PemilikpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilikpembayaranController>(
      () => PemilikpembayaranController(),
    );
  }
}

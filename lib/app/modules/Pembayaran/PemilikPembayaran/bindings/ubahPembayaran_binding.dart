import 'package:get/get.dart';

import '../controllers/ubahPembayaran_controller.dart';

class PemilikubahpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilikubahpembayaranController>(
      () => PemilikubahpembayaranController(),
    );
  }
}

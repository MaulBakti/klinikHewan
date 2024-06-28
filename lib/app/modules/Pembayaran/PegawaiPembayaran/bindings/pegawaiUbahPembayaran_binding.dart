import 'package:get/get.dart';

import '../controllers/ubahPembayaran_controller.dart';

class PegawaiubahpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PegawaiubahpembayaranController>(
      () => PegawaiubahpembayaranController(),
    );
  }
}

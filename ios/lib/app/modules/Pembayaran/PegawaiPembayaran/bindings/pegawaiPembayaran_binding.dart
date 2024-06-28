import 'package:get/get.dart';

import '../controllers/pegawaiPembayaran_controller.dart';

class PegawaipembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PegawaipembayaranController>(
      () => PegawaipembayaranController(),
    );
  }
}

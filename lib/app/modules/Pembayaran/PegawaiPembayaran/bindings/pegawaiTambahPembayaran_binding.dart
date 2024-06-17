import 'package:get/get.dart';

import '../controllers/tambahPembayaran_controller.dart';

class PegawaitambahpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PegawaitambahpembayaranController>(
      () => PegawaitambahpembayaranController(),
    );
  }
}

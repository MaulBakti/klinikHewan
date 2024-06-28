import 'package:get/get.dart';

import '../controllers/tambahPembayaran_controller.dart';

class PemiliktambahpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemiliktambahpembayaranController>(
      () => PemiliktambahpembayaranController(),
    );
  }
}

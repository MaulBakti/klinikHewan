import 'package:get/get.dart';

import '../controllers/adminPembayaran_controller.dart';

class AdminpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminpembayaranController>(
      () => AdminpembayaranController(),
    );
  }
}

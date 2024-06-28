import 'package:get/get.dart';

import '../controllers/adminUbahPembayaran_controller.dart';

class AdminubahpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminubahpembayaranController>(
      () => AdminubahpembayaranController(),
    );
  }
}

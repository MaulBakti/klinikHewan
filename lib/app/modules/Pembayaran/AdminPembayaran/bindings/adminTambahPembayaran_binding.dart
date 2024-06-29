import 'package:get/get.dart';

import '../controllers/adminTambahPembayaran_controller.dart';

class AdmintambahpembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdmintambahpembayaranController>(
      () => AdmintambahpembayaranController(),
    );
  }
}

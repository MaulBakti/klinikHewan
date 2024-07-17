import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/controllers/pembayaran_controller.dart';

class pembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<pembayaranController>(
      () => pembayaranController(),
    );
  }
}

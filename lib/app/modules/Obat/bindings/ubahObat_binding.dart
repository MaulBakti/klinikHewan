import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Obat/controllers/ubahObat_controller.dart';

class UbahobatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahobatController>(() => UbahobatController());
  }
}

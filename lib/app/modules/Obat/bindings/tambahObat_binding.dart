import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Obat/controllers/tambahObat_controller.dart';

class TambahobatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahobatController>(() => TambahobatController());
  }
}

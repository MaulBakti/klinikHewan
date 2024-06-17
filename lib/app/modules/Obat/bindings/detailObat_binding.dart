import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Obat/controllers/detailObat_controller.dart';

class DetailobatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailobatController>(() => DetailobatController());
  }
}

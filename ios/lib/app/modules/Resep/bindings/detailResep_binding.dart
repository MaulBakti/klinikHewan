import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/resep/controllers/detailResep_controller.dart';

class DetailresepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailresepController>(() => DetailresepController());
  }
}

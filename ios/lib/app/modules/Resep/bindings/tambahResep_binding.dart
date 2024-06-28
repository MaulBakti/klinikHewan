import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/resep/controllers/tambahResep_controller.dart';

class TambahresepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahresepController>(() => TambahresepController());
  }
}

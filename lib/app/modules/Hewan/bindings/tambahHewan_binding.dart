import 'package:get/get.dart';
import '../controllers/tambahHewan_controller.dart';

class TambahHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahHewanController>(
      () => TambahHewanController(),
    );
  }
}

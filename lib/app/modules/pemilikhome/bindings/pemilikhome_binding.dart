import 'package:get/get.dart';

import '../controllers/pemilikhome_controller.dart';

class PemilikhomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilikhomeController>(
      () => PemilikhomeController(),
    );
  }
}

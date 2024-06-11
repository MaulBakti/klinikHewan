import 'package:get/get.dart';

import '../controllers/pemilikHome_controller.dart';

class PemilikhomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilikhomeController>(
      () => PemilikhomeController(),
    );
  }
}

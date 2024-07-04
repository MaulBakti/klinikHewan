import 'package:get/get.dart';

import '../controllers/pemilik_controller.dart';

class PemilikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilikController>(
      () => PemilikController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/pemilikLogin_controller.dart';

class PemilikloginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PemilikloginController>(
      () => PemilikloginController(),
    );
  }
}

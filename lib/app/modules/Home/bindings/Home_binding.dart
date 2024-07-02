import 'package:get/get.dart';

import '../controllers/Home_controller.dart';

class homeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/adminHome_controller.dart';

class AdminhomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminhomeController>(
      () => AdminhomeController(),
    );
  }
}

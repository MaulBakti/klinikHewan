import 'package:get/get.dart';

import '../controllers/adminLogin_controller.dart';

class AdminloginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminloginController>(
      () => AdminloginController(),
    );
  }
}

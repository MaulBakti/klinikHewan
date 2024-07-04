import 'package:get/get.dart';

import '../controllers/forgotpass_controller.dart';

class ForgotpassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotpassController>(
      () => ForgotpassController(),
    );
  }
}

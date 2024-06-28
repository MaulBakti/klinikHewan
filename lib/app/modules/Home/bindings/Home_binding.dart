import 'package:get/get.dart';

import '../controllers/Home_controller.dart';
// import '../../Login/controllers/login_controller.dart';

class homeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
  }
}

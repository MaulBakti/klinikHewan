import 'package:get/get.dart';

import '../controllers/Home_controller.dart';
<<<<<<< HEAD
// import '../../Login/controllers/login_controller.dart';
=======
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867

class homeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
<<<<<<< HEAD
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
=======
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
  }
}

import 'package:get/get.dart';

import '../controllers/profile_pemilik_controller.dart';

class ProfilePemilikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePemilikController>(
      () => ProfilePemilikController(),
    );
  }
}

import 'package:get/get.dart';

class TentangController extends GetxController {
  //TODO: Implement TentangController
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed('/pemilikhome');
        break;
      case 1:
        Get.offAllNamed('/tentang');
        break;
      case 2:
        Get.offAllNamed('/harga');
        break;
      case 3:
        Get.toNamed('/profile-pemilik');
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

import 'package:get/get.dart';

class HargaController extends GetxController {
  //TODO: Implement HargaController
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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print(selectedIndex.value);
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

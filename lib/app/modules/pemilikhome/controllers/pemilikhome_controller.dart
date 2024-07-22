import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PemilikhomeController extends GetxController {
  //TODO: Implement PemilikhomeController
  final box = GetStorage();
  var role = 'admin'.obs;
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

  Future<String?> getRole() async {
    final role = box.read('role');
    return role;
  }

  @override
  void onInit() {
    super.onInit();
    print('Initializing HomeController');
    getRole().then((value) {
      if (value != null) {
        role.value = value;
      }
    });
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

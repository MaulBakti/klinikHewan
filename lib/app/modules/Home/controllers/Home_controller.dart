import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var role = ''.obs; // Observable for user role
  final box = GetStorage(); // Instance of GetStorage

  // Method to change role
  void changeRole(String newRole) {
    role.value = newRole;
    box.write('role', newRole);
    // Add any additional logic needed here
  }

  // Method to navigate to HewanView based on role
  void navigateToHewanView() {
    final String? token = box.read('token');
    final String? currentRole = box.read('role');
    if (token != null && currentRole != null) {
      Get.toNamed(Routes.HEWAN,
          parameters: {'role': currentRole, 'token': token});
    } else {
      // Handle case where token or role is null, perhaps show an error or redirect to login
      Get.snackbar('Error', 'Token or role not found');
      Get.offAllNamed(
          Routes.LOGIN); // Redirect to login page if token or role is not found
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initial setup or configuration can be done here
    role.value = box.read('role') ??
        ''; // Set default role from storage or empty if not available
    print('HomeController initialized with role: ${role.value}');
  }

  @override
  void onReady() {
    super.onReady();
    // Additional setup when the controller is ready
  }

  @override
  void onClose() {
    super.onClose();
    // Clean up resources or close connections if needed
  }
}

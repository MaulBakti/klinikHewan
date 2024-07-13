import 'package:get/get.dart';

class ForgotpassController extends GetxController {
  var usernameOrTelp = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void resetPassword() {
    if (usernameOrTelp.value.isEmpty) {
      Get.snackbar('Error', 'Username/Telephone is required');
      return;
    }

    if (newPassword.value.isEmpty) {
      Get.snackbar('Error', 'New Password is required');
      return;
    }

    if (confirmPassword.value.isEmpty) {
      Get.snackbar('Error', 'Confirm Password is required');
      return;
    }

    if (newPassword.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    // Perform the password reset logic (e.g., API call)
    Get.snackbar('Success', 'Password has been reset');
  }
}

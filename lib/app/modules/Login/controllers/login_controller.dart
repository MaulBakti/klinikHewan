import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController


  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  void login() async {
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;

      await Future.delayed(Duration(seconds: 2));
      isLoading.value = false;
      Get.snackbar('Login', 'Login successful');

      Get.toNamed('/home');
    } else {
      Get.snackbar('Error', 'Please enter email and password');
    }
  }
  
  final count = 0.obs;
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

  void increment() => count.value++;
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  var role = 'admin'.obs; // Observable untuk role pengguna

  Future<String?> getRole() async {
    final role = box.read('role');
    return role;
  }

  // Method untuk navigasi ke halaman HEWAN berdasarkan role
  void navigateToHewanView(String role) {
    final String? token = box.read('token');
    if (token != null) {
      Get.toNamed(Routes.HEWAN, parameters: {'role': role, 'token': token});
    } else {
      // Handle case where token is null, perhaps show an error or redirect to login
      Get.snackbar('Error', 'Token not found');
      // Example of redirecting to login page if token is not found
      // Get.offAllNamed(Routes.LOGIN);
    }
  }

  void navigateToDoctorView(String role) {
    final String? token = box.read('token');
    if (token != null) {
      Get.toNamed(Routes.DOKTER, parameters: {'role': role, 'token': token});
    } else {
      // Handle case where token is null, perhaps show an error or redirect to login
      Get.snackbar('Error', 'Token not found');
      // Example of redirecting to login page if token is not found
      // Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize or set up early configurations
    getRole().then((value) {
      if (value != null) {
        role.value = value;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    // Di sini Anda dapat melakukan hal yang diperlukan saat controller siap digunakan
  }

  @override
  void onClose() {
    super.onClose();
    // Bersihkan sumber daya atau tutup koneksi jika diperlukan
  }
}

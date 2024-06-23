import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var role = 'admin'.obs; // Observable untuk role pengguna

  // Method untuk mengubah role
  void changeRole(String newRole) {
    role.value = newRole;
    // Anda dapat menambahkan logika lain yang diperlukan di sini
  }

  // Method untuk navigasi ke halaman HEWAN berdasarkan role
  void navigateToHewanView(String role) {
    final String? token = GetStorage().read('token');
    if (token != null) {
      Get.toNamed(Routes.HEWAN, parameters: {'role': role, 'token': token});
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
    // Inisialisasi atau pengaturan awal dapat dilakukan di sini
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

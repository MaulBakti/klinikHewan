import 'package:get/get.dart';

class HomeController extends GetxController {
  var role = 'admin'.obs; // Observable untuk role pengguna

  // Method untuk mengubah role
  void changeRole(String newRole) {
    role.value = newRole;
    // Anda dapat menambahkan logika lain yang diperlukan di sini
  }

  // Method untuk navigasi ke halaman berdasarkan role
  void navigateToHomePage() {
    switch (role.value) {
      case 'admin':
        Get.offAllNamed('/adminhome');
        break;
      case 'pegawai':
        Get.offAllNamed('/pegawaihome');
        break;
      case 'pemilik':
        Get.offAllNamed('/pemilikhome');
        break;
      default:
        Get.snackbar('Error', 'Invalid role');
        break;
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

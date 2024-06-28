import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/routes/app_pages.dart';

class HomeController extends GetxController {
<<<<<<< HEAD
  var role = 'admin'.obs;
  final box = GetStorage(); // Observable untuk role pengguna

  // Method untuk mengubah role
  void changeRole() {
    // role = GetStorage().read('role');
  }

  // Method untuk navigasi ke halaman HEWAN berdasarkan role
  void navigateToHewanView(String newRole) {
    final String? token = GetStorage().read('token');
    newRole = GetStorage().read('role');
    if (token != null) {
      Get.toNamed(Routes.HEWAN, parameters: {'role': newRole, 'token': token});
=======
  var role = ''.obs; // Observable untuk role pengguna

  // Method untuk mengubah role
  void changeRole(String newRole) {
    role.value = newRole;
    // Anda dapat menambahkan logika lain yang diperlukan di sini
  }

  // Method untuk navigasi ke halaman HEWAN berdasarkan role
  void navigateToHewanView() {
    final String? token = GetStorage().read('token');
    if (token != null) {
      Get.toNamed(Routes.HEWAN,
          parameters: {'role': role.value, 'token': token});
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
    } else {
      // Handle case where token is null, perhaps show an error or redirect to login
      Get.snackbar('Error', 'Token not found');
      // Example of redirecting to login page if token is not found
<<<<<<< HEAD
      // Get.offAllNamed(Routes.LOGIN);
=======
      Get.offAllNamed(Routes.LOGIN);
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
    }
  }

  @override
  void onInit() {
    super.onInit();
<<<<<<< HEAD
    // Inisialisasi atau pengaturan awal dapat dilakukan di sini
=======
    role.value = ''; // Set default role to empty or handle it as needed
    print('HomeController initialized');
>>>>>>> ab99608de9f73f44cbf13b38944e80b8591f7867
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

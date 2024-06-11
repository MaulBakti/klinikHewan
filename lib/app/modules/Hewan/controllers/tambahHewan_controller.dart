import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';

class TambahHewanController extends GetxController {
  var nama = ''.obs;
  var jenis = ''.obs;
  var usia = ''.obs;
  var isLoading = false.obs;
  var token = ''.obs;

  void createHewan() async {
    if (nama.value.isNotEmpty &&
        jenis.value.isNotEmpty &&
        usia.value.isNotEmpty) {
      isLoading.value = true;

      // Data yang akan dikirim ke API
      Map<String, dynamic> hewanData = {
        'nama': nama.value,
        'jenis': jenis.value,
        'usia': usia.value,
      };

      // Panggil layanan API untuk menambahkan hewan baru
      final response = await ApiService.createHewan(hewanData, token.value);

      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar('Sukses', 'Hewan berhasil ditambahkan');
      } else {
        Get.snackbar('Error', 'Gagal menambahkan hewan');
      }
    } else {
      Get.snackbar('Error', 'Mohon isi semua data');
    }
  }
}

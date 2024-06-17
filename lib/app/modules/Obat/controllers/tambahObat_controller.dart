import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';

class TambahobatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var nama = ''.obs;
  var keterangan = ''.obs;
  var token = ''.obs;

  void createObat() async {
    if (nama.value.isNotEmpty && keterangan.value.isNotEmpty) {
      isLoading.value = true;

      // Data yang akan dikirim ke API
      Map<String, dynamic> obatData = {
        'nama_obat': nama.value,
        'keterangan': keterangan.value,
      };

      // Panggil layanan API untuk menambahkan obat baru
      // final response = await ApiService.createObat(obat, token.value);

      isLoading.value = false;

      //   if (response.statusCode == 200) {
      //     Get.snackbar('Sukses', 'obat berhasil ditambahkan');
      //   } else {
      //     Get.snackbar('Error', 'Gagal menambahkan obat');
      //   }
      // } else {
      //   Get.snackbar('Error', 'Mohon isi semua data');
    }
  }
}

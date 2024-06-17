import 'package:get/get.dart';

class TambahresepController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var rekamMedis = ''.obs;
  var obat = ''.obs;
  var jumlah = ''.obs;

  void createResep() async {
    if (rekamMedis.value.isNotEmpty && obat.value.isNotEmpty) {
      isLoading.value = true;

      // Data yang akan dikirim ke API
      Map<String, dynamic> obatData = {
        'id_rekam_medis': rekamMedis,
        'nama_obat': obat.value,
        'keterangan': jumlah.value,
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

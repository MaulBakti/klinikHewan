import 'package:get/get.dart';
import 'package:klinik_hewan/app/data/providers/api_service.dart';

class TambahpegawaiController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var jabatan = ''.obs;
  var alamat = ''.obs;
  var noTelp = ''.obs;
  var token = ''.obs;

  void createPegawai() async {
    if (username.value.isNotEmpty && password.value.isNotEmpty) {
      isLoading.value = true;

      // Data yang akan dikirim ke API
      Map<String, dynamic> pegawaiData = {
        'username': username.value,
        'password': password.value,
      };

      // Panggil layanan API untuk menambahkan pegawai baru
      // final response = await ApiService.createpegawai(pegawai, token.value);

      isLoading.value = false;

      //   if (response.statusCode == 200) {
      //     Get.snackbar('Sukses', 'pegawai berhasil ditambahkan');
      //   } else {
      //     Get.snackbar('Error', 'Gagal menambahkan pegawai');
      //   }
      // } else {
      //   Get.snackbar('Error', 'Mohon isi semua data');
    }
  }
}

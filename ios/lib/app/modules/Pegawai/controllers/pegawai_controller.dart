import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pegawai.dart';

class PegawaiController extends GetxController {
  var isLoading = false.obs;
  var pegawaiList = <Pegawai>[].obs;

  void fetchDataPegawai() async {
    isLoading.value = true;

    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/pegawai'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        pegawaiList.clear();

        responseData.forEach((pegawaiData) {
          final pegawai = Pegawai.fromJson(pegawaiData);
          pegawaiList.add(pegawai);
        });

        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to fetch data from the API');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataPegawai();
  }
}

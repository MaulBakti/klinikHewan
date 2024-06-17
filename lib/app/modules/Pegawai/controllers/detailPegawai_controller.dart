import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Login/model/adminLogin.dart';

class DetailpegawaiController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var pegawaiList = <pegawai>[].obs;
}

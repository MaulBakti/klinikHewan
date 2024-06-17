import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';

class UbahdoctorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var doktorList = <Dokter>[].obs;
  var namaDoctor = ''.obs;
  var spesialis = ''.obs;
  var token = ''.obs;

  void updateDoctor() async {}
}

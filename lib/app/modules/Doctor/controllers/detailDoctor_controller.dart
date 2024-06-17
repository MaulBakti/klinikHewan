import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';

class DetaildoctorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var doctorList = <Dokter>[].obs;
}

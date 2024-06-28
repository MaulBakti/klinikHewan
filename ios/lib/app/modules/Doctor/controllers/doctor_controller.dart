import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Doctor/model/doctor.dart';

class DoctorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var doctorList = <Doctor>[].obs;
}

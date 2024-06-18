import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';

class DetailappointmentController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var appointmenList = <Appointment>[].obs;
}

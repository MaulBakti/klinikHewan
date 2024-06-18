import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';

class UbabhappointmentController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var appointmentList = <Appointment>[].obs;
  var doctor = ''.obs;
  var hewan = ''.obs;
  var tanggal = ''.obs;
  var catatan = ''.obs;
  var token = ''.obs;

  void updateAppointment() async {}
}

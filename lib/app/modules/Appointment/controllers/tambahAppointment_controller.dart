import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/model/appointment.dart';

class TambahappointmentController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var appointmentList = <Appointment>[].obs;
}

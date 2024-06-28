import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/controllers/appointment_controller.dart';

class AppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentController>(() => AppointmentController());
  }
}

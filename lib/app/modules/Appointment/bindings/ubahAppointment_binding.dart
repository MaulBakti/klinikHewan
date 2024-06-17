import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/controllers/ubahAppointment_controller.dart';

class UbahappointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbabhappointmentController>(() => UbabhappointmentController());
  }
}

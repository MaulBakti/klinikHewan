import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/controllers/tambahAppointment_controller.dart';

class TambahappointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahappointmentController>(
        () => TambahappointmentController());
  }
}

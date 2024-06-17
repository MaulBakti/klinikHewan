import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Appointment/controllers/detailAppointment_controller.dart';

class DetailappointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailappointmentController>(
        () => DetailappointmentController());
  }
}

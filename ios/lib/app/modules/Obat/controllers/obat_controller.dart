import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Obat/model/obat.dart';

class ObatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var obatList = <Obat>[].obs;
}

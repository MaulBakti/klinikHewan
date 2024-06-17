import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Resep/model/resep.dart';

class DetailresepController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var resepList = <Resep>[].obs;
}

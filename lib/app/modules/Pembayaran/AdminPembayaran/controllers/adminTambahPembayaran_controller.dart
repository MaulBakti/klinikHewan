import 'package:get/get.dart';
import '../model/pembayaran.dart';

class AdmintambahpembayaranController extends GetxController {
  //TODO: Implement PembayaranController

  var data = <Pembayaran>[].obs;

  void addPemilik(Pembayaran pembayaran) {
    data.add(pembayaran);
  }
  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  // }
  //
  // void increment() => count.value++;
}

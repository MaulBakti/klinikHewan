import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/routes/app_pages.dart';
import 'package:klinik_hewan/app/modules/home/controllers/home_controller.dart';
import 'package:klinik_hewan/app/modules/login/controllers/login_controller.dart';

void main() async {
  // Pastikan binding widget diinisialisasi terlebih dahulu
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage
  await GetStorage.init();

  // Bindings untuk dependency injection
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Klinik Hewan',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding:
          InitialBinding(), // Bindings untuk inisialisasi dependencies
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController()); // Contoh penggunaan Get.put
    Get.put(LoginController()); // Contoh penggunaan Get.put
  }
}

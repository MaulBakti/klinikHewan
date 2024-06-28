import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:klinik_hewan/app/routes/app_pages.dart';
import 'package:klinik_hewan/app/modules/home/controllers/home_controller.dart';
import 'package:klinik_hewan/app/modules/login/controllers/login_controller.dart';

void main() async {
  // Ensure binding of widgets is initialized first
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage for local storage
  await GetStorage.init();

  // Run your application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Klinik Hewan',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding:
          InitialBinding(), // Use initialBinding for dependency injection
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize your controllers here using Get.put
    Get.put(HomeController());
    Get.put(LoginController());
  }
}

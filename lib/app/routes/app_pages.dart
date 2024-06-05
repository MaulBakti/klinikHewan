import 'package:get/get.dart';

import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Pegawai/bindings/pegawai_binding.dart';
import '../modules/Pegawai/views/pegawai_view.dart';
import '../modules/Pembayaran/bindings/pembayaran_binding.dart';
import '../modules/Pembayaran/views/pembayaran_view.dart';
import '../modules/Pemilik/bindings/pemilik_binding.dart';
import '../modules/Pemilik/views/pemilik_view.dart';
import '../modules/RekamMedis/bindings/rekam_medis_binding.dart';
import '../modules/RekamMedis/views/rekam_medis_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PEMILIK,
      page: () => const PemilikView(),
      binding: PemilikBinding(),
    ),
    GetPage(
      name: _Paths.PEGAWAI,
      page: () => const PegawaiView(),
      binding: PegawaiBinding(),
    ),
    GetPage(
      name: _Paths.HEWAN,
      page: () => const HewanView(),
      binding: HewanBinding(),
    ),
    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () => const RekamMedisView(),
      binding: RekamMedisBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
  ];
}

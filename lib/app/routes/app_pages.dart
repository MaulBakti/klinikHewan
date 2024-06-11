import 'package:get/get.dart';
import 'package:klinik_hewan/app/modules/Dashboard/bindings/dashboard_binding.dart';
import 'package:klinik_hewan/app/modules/Dashboard/views/dashboard_view.dart';

import '../modules/Login/AdminLogin/bindings/adminLogin_binding.dart';
import '../modules/Login/AdminLogin/views/adminLogin_view.dart';
import '../modules/Login/PegawaiLogin/bindings/pegawaiLogin_binding.dart';
import '../modules/Login/PegawaiLogin/views/pegawaiLogin_view.dart';
import '../modules/Login/PemilikLogin/bindings/pemilikLogin_binding.dart';
import '../modules/Login/PemilikLogin/views/pemilikLogin_view.dart';
import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';
import '../modules/Hewan/bindings/tambahHewan_binding.dart';
import '../modules/Hewan/views/tambahHewan_view.dart';
import '../modules/RekamMedis/bindings/rekam_medis_binding.dart';
import '../modules/RekamMedis/views/rekam_medis_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/Pembayaran/bindings/pembayaran_binding.dart';
import '../modules/Pembayaran/views/pembayaran_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HEWAN,
      page: () => HewanView(),
      binding: HewanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_HEWAN,
      page: () => TambahHewanView(),
      binding: TambahHewanBinding(),
    ),
    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () => const RekamMedisView(),
      binding: RekamMedisBinding(),
    ),
    // Route for admin login
    GetPage(
      name: _Paths.ADMIN_LOGIN,
      page: () => const AdminloginView(),
      binding: AdminloginBinding(),
    ),
    // Route for pegawai login
    GetPage(
      name: _Paths.PEGAWAI_LOGIN,
      page: () => const PegawailoginView(),
      binding: PegawailoginBinding(),
    ),
    // Route for pemilik login
    GetPage(
      name: _Paths.PEMILIK_LOGIN,
      page: () => const PemilikloginView(),
      binding: PemilikloginBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}

import 'package:get/get.dart';
// Dashboard
import 'package:klinik_hewan/app/modules/Dashboard/bindings/dashboard_binding.dart';
import 'package:klinik_hewan/app/modules/Dashboard/views/dashboard_view.dart';
import 'package:klinik_hewan/app/modules/Home/PegawaiHome/bindings/pegawaiHome_binding.dart';
import 'package:klinik_hewan/app/modules/Home/PegawaiHome/views/pegawaiHome_view.dart';
import 'package:klinik_hewan/app/modules/Home/PemilikHome/bindings/pemilikHome_binding.dart';
import 'package:klinik_hewan/app/modules/Home/PemilikHome/views/pemilikHome_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PegawaiPembayaran/bindings/pegawaiPembayaran_binding.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PegawaiPembayaran/views/pegawaiPembayaran_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PemilikPembayaran/bindings/pemilikPembayaran_binding.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PemilikPembayaran/views/pemilikPembayaran_view.dart';
// Home
import '../modules/Home/AdminHome/bindings/adminHome_binding.dart';
import '../modules/Home/AdminHome/views/adminHome_view.dart';
// Login Admin
import '../modules/Login/AdminLogin/bindings/adminLogin_binding.dart';
import '../modules/Login/AdminLogin/views/adminLogin_view.dart';
// Login Pegawai
import '../modules/Login/PegawaiLogin/bindings/pegawaiLogin_binding.dart';
import '../modules/Login/PegawaiLogin/views/pegawaiLogin_view.dart';
// Login Pemilik
import '../modules/Login/PemilikLogin/bindings/pemilikLogin_binding.dart';
import '../modules/Login/PemilikLogin/views/pemilikLogin_view.dart';
// Hewan
import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';
import '../modules/Hewan/bindings/tambahHewan_binding.dart';
import '../modules/Hewan/views/tambahHewan_view.dart';
// Rekam Medis
import '../modules/RekamMedis/bindings/rekam_medis_binding.dart';
import '../modules/RekamMedis/views/rekam_medis_view.dart';
// Pembayaran
import '../modules/Pembayaran/AdminPembayaran/bindings/adminPembayaran_binding.dart';
import '../modules/Pembayaran/AdminPembayaran/views/adminPembayaran_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    // Dashboard
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),

    /* HOME */
    // Home Admin
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminhomeView(),
      binding: AdminhomeBinding(),
    ),
    // Home Pegawai
    GetPage(
      name: _Paths.PEGAWAI_HOME,
      page: () => const PegawaihomeView(),
      binding: PegawaihomeBinding(),
    ),
    // Home Pemilik
    GetPage(
      name: _Paths.PEMILIK_HOME,
      page: () => const PemilikhomeView(),
      binding: PemilikhomeBinding(),
    ),

    /* LOGIN */
    // Admin Login
    GetPage(
      name: _Paths.ADMIN_LOGIN,
      page: () => const AdminloginView(),
      binding: AdminloginBinding(),
    ),
    // Pegawai Login
    GetPage(
      name: _Paths.PEGAWAI_LOGIN,
      page: () => const PegawailoginView(),
      binding: PegawailoginBinding(),
    ),
    // Pemilik Login
    GetPage(
      name: _Paths.PEMILIK_LOGIN,
      page: () => const PemilikloginView(),
      binding: PemilikloginBinding(),
    ),

    /* HEWAN */
    GetPage(
      name: _Paths.HEWAN,
      page: () => HewanView(),
      binding: HewanBinding(),
    ),
    GetPage(
      name: _Paths.HEWAN,
      page: () => TambahHewanView(),
      binding: TambahHewanBinding(),
    ),
    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () => const RekamMedisView(),
      binding: RekamMedisBinding(),
    ),

    /* PEMBAYARAN */
    // Pembayaran Admin
    GetPage(
      name: _Paths.ADMIN_PEMBAYARAN,
      page: () => const AdminpembayaranView(),
      binding: AdminpembayaranBinding(),
    ),
    // Pegawai Admin
    GetPage(
      name: _Paths.PEGAWAI_PEMBAYARAN,
      page: () => const PegawaipembayaranView(),
      binding: PegawaipembayaranBinding(),
    ),
    // Pemilik
    GetPage(
      name: _Paths.PEMILIK_PEMBAYARAN,
      page: () => const PemilikpembayaranView(),
      binding: PemilikpembayaranBinding(),
    ),
  ];
}

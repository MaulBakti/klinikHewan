import 'package:get/get.dart';
// Dashboard
import 'package:klinik_hewan/app/modules/Dashboard/bindings/dashboard_binding.dart';
import 'package:klinik_hewan/app/modules/Dashboard/views/dashboard_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PegawaiPembayaran/bindings/pegawaiPembayaran_binding.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PegawaiPembayaran/views/pegawaiPembayaran_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PemilikPembayaran/bindings/pemilikPembayaran_binding.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PemilikPembayaran/views/pemilikPembayaran_view.dart';
// Home
import '../modules/Home/bindings/Home_binding.dart';
import '../modules/Home/views/Home_view.dart';
// Login
import '../modules/Login/views/login_view.dart';
// Hewan
import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';
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

    /* LOGIN */
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
    ),

    /* HOME */
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: homeBinding(),
    ),

    /* HEWAN */
    GetPage(
      name: _Paths.HEWAN,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return HewanView(
            role: role, token: token); // Pass token to HewanView constructor
      },
      binding: HewanBinding(),
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

import 'package:get/get.dart';
// Dashboard
import 'package:klinik_hewan/app/modules/Dashboard/bindings/dashboard_binding.dart';
import 'package:klinik_hewan/app/modules/Dashboard/views/dashboard_view.dart';
import 'package:klinik_hewan/app/modules/Home/PegawaiHome/bindings/pegawaiHome_binding.dart';
import 'package:klinik_hewan/app/modules/Home/PegawaiHome/views/pegawaiHome_view.dart';
import 'package:klinik_hewan/app/modules/Home/PemilikHome/bindings/pemilikHome_binding.dart';
import 'package:klinik_hewan/app/modules/Home/PemilikHome/views/pemilikHome_view.dart';
import 'package:klinik_hewan/app/modules/Pegawai/bindings/pegawai_binding.dart';
import 'package:klinik_hewan/app/modules/Pegawai/view/pegawai_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PegawaiPembayaran/bindings/pegawaiPembayaran_binding.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PegawaiPembayaran/views/pegawaiPembayaran_view.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PemilikPembayaran/bindings/pemilikPembayaran_binding.dart';
import 'package:klinik_hewan/app/modules/Pembayaran/PemilikPembayaran/views/pemilikPembayaran_view.dart';
// Home
import '../modules/Home/AdminHome/bindings/adminHome_binding.dart';
import '../modules/Home/AdminHome/views/adminHome_view.dart';
// Login
import '../modules/Login/views/login_view.dart';
// Hewan
import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';

// Tambah Hewan
import '../modules/Hewan/bindings/tambahHewan_binding.dart';
import '../modules/Hewan/views/tambahHewan_view.dart';

// Ubah Hewan
import '../modules/Hewan/bindings/ubahHewan_binding.dart';
import '../modules/Hewan/views/ubahHewan_view.dart';

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

    // PEGAWAI
    GetPage(
      name: _Paths.PEGAWAI,
      page: () => const PegawaiView(),
      binding: PegawaiBinding(),
    ),

    // PEMILIK
    GetPage(
      name: _Paths.PEMILIK,
      page: () => const PemilikhomeView(),
      binding: PemilikhomeBinding(),
    ),

    /* HEWAN */
    GetPage(
      name: _Paths.HEWAN,
      page: () => HewanView(),
      binding: HewanBinding(),
    ),
    // GetPage(
    //   name: _Paths.TAMBAHHEWAN,
    //   page: () => TambahHewanView(),
    //   binding: TambahHewanBinding(),
    // ),
    GetPage(
      name: _Paths.UBAHHEWAN,
      page: () => ubahHewanView(),
      binding: UbahhewanBinding(),
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

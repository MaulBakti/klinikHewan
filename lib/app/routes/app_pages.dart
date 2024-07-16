import 'package:get/get.dart';

import '../modules/Appointment/views/appointment_view.dart';
import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/Doctor/views/doctor_view.dart';
import '../modules/ForgotPass/bindings/forgotpass_binding.dart';
import '../modules/ForgotPass/views/forgotpass_view.dart';
import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';
import '../modules/Home/bindings/Home_binding.dart';
import '../modules/Home/views/Home_view.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Obat/views/obat_view.dart';
import '../modules/Pegawai/view/pegawai_view.dart';
import '../modules/Pembayaran/AdminPembayaran/bindings/adminPembayaran_binding.dart';
import '../modules/Pembayaran/AdminPembayaran/views/adminPembayaran_view.dart';
import '../modules/Pembayaran/PegawaiPembayaran/bindings/pegawaiPembayaran_binding.dart';
import '../modules/Pembayaran/PegawaiPembayaran/views/pegawaiPembayaran_view.dart';
import '../modules/Pemilik/bindings/pemilik_binding.dart';
import '../modules/Pemilik/views/pemilik_view.dart';
import '../modules/Register/bindings/regist_binding.dart';
import '../modules/Register/views/regist_view.dart';
import '../modules/RekamMedis/bindings/rekam_medis_binding.dart';
import '../modules/RekamMedis/views/rekam_medis_view.dart';
import '../modules/Resep/views/resep_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profilePemilik/bindings/profile_pemilik_binding.dart';
import '../modules/profilePemilik/views/profile_pemilik_view.dart';

// Profile

// Dashboard
// Obat
// Pegawai

// Home
// Login

// Hewan
// Rekam Medis
// Pembayaran
// Doctor
// import '../modules/Doctor/bindings/doctor_binding.dart';
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

    /* DOCTOR */
    GetPage(
      name: _Paths.DOCTOR,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return DoctorView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      // binding: (),
    ),

    /* PEGAWAI */
    GetPage(
      name: _Paths.PEGAWAI,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return PegawaiView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      // binding: (),
    ),

    GetPage(
      name: _Paths.OBAT,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return ObatView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      // binding: (),
    ),

    GetPage(
      name: _Paths.RESEP,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return ResepView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      // binding: (),
    ),

    GetPage(
      name: _Paths.APPOINTMENT,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return AppointmentView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      // binding: (),
    ),

    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return RekamMedisView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
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
      name: _Paths.PEMILIK,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return PemilikView(role: role, token: token);
      },
      binding: PemilikBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASS,
      page: () => const ForgotpassView(),
      binding: ForgotpassBinding(),
    ),
    GetPage(
      name: _Paths.REGIST,
      page: () => const RegistView(),
      binding: RegistBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PEMILIK,
      page: () => ProfilePemilikView(),
      binding: ProfilePemilikBinding(),
    ),
  ];
}

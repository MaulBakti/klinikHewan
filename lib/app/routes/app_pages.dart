import 'package:get/get.dart';

import '../modules/Appointment/Bindings/appointment_binding.dart';
import '../modules/Appointment/views/appointment_view.dart';
import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/Dokter/bindings/dokter_binding.dart';
import '../modules/Dokter/views/dokter_view.dart';
import '../modules/ForgotPass/bindings/forgotpass_binding.dart';
import '../modules/ForgotPass/views/forgotpass_view.dart';
import '../modules/Hewan/bindings/hewan_binding.dart';
import '../modules/Hewan/views/hewan_view.dart';
import '../modules/Home/bindings/Home_binding.dart';
import '../modules/Home/views/Home_view.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Obat/bindings/obat_binding.dart';
import '../modules/Obat/views/obat_view.dart';
import '../modules/Pegawai/bindings/pegawai_binding.dart';
import '../modules/Pegawai/view/pegawai_view.dart';
import '../modules/Pembayaran/bindings/pembayaran_binding.dart';
import '../modules/Pembayaran/views/pembayaran_view.dart';
import '../modules/Pemilik/bindings/pemilik_binding.dart';
import '../modules/Pemilik/views/pemilik_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/RekamMedis/bindings/rekam_medis_binding.dart';
import '../modules/RekamMedis/views/rekam_medis_view.dart';
import '../modules/Resep/bindings/resep_binding.dart';
import '../modules/Resep/views/resep_view.dart';
import '../modules/Harga/bindings/harga_binding.dart';
import '../modules/Harga/views/harga_view.dart';
import '../modules/pemilikhome/bindings/pemilikhome_binding.dart';
import '../modules/pemilikhome/views/pemilikhome_view.dart';
import '../modules/profilePegawai/bindings/profile_pegawai_binding.dart';
import '../modules/profilePegawai/views/profile_pegawai_view.dart';
import '../modules/profilePemilik/bindings/profile_pemilik_binding.dart';
import '../modules/profilePemilik/views/profile_pemilik_view.dart';
import '../modules/tentang/bindings/tentang_binding.dart';
import '../modules/tentang/views/tentang_view.dart';

// Register
// Login
// import '../modules/Login/bindings/login_binding.dart';
// Forgot Pass
// Dashboard
// Hewan
// Home
// Obat
// Pegawai

// Pembayaran
// Pemilik
// Rekam Medis
// Resep
// import '../modules/Resep/views/resep_view.dart';
// Profil Pegawai
// Profil Pemilik
// Doctor
// Appointment

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    // Dashboard
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),

    /* LOGIN */
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      // binding: LoginBinding(),
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
        final token = Get.parameters['token'] ?? '';
        final idPemilik = Get.parameters['id_pemilik'] ?? '';
        final id = int.tryParse(Get.parameters['id_pemilik'] ?? '0') ?? 0;
        // default token
        return HewanView(
            role: role,
            token: token,
            idPemilik: idPemilik,
            id: id // Pass token to HewanView constructor
            ); // Pass token to HewanView constructor
      },
      binding: HewanBinding(),
    ),

    /* DOKTER */
    GetPage(
      name: _Paths.DOKTER,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return DokterView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      binding: DokterBinding(),
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
      binding: PegawaiBinding(),
    ),

    // Obat
    GetPage(
      name: _Paths.OBAT,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return ObatView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      binding: ObatBinding(),
    ),

    // Resep
    GetPage(
      name: _Paths.RESEP,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        return ResepView(
            role: role, token: token); // Pass token to DoctorView constructor
      },
      // binding: ResepBinding(),
    ),

    // Appointment
    GetPage(
      name: _Paths.APPOINTMENT,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? '';
        final idPemilik = Get.parameters['id_pemilik'] ?? ''; // default token
        return AppointmentView(
            role: role,
            token: token,
            idPemilik: idPemilik); // Pass token to DoctorView constructor
      },
      binding: AppointmentBinding(),
    ),

    // Rekam Medis
    GetPage(
      name: _Paths.REKAM_MEDIS,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? '';
        final idPemilik = Get.parameters['id_pemilik'] ?? ''; // default token
        // default token
        return RekamMedisView(
            role: role,
            token: token,
            idPemilik: idPemilik); // Pass token to DoctorView constructor
      },
      binding: RekamMedisBinding(),
    ),

    // Pembayaran
    GetPage(
      name: _Paths.ADMIN_PEMBAYARAN,
      page: () {
        final role = Get.parameters['role'] ?? 'admin'; // default role
        final token = Get.parameters['token'] ?? ''; // default token
        final idPemilik = Get.parameters['id_pemilik'] ?? ''; // default token
        return pembayaranView(
            role: role,
            token: token,
            idPemilik: idPemilik); // Pass token to DoctorView constructor
      },
      binding: pembayaranBinding(),
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

    // Forgot Pass
    GetPage(
      name: _Paths.FORGOTPASS,
      page: () => const ForgotpassView(),
      binding: ForgotpassBinding(),
    ),

    // Register
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),

    // Profil Pegawai
    GetPage(
      name: _Paths.PROFILE_PEGAWAI,
      page: () => ProfilePegawaiView(),
      binding: ProfilePegawaiBinding(),
    ),

    // Profile Pemilik
    GetPage(
      name: _Paths.PROFILE_PEMILIK,
      page: () => ProfilePemilikView(),
      binding: ProfilePemilikBinding(),
    ),
    GetPage(
      name: _Paths.PEMILIKHOME,
      page: () => const PemilikhomeView(),
      binding: PemilikhomeBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG,
      page: () => const TentangView(),
      binding: TentangBinding(),
    ),
    GetPage(
      name: _Paths.HARGA,
      page: () => const HargaView(),
      binding: HargaBinding(),
    ),
  ];
}

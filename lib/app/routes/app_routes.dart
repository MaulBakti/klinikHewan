part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  // Dashboard
  static const DASHBOARD = _Paths.DASHBOARD;

  // Login
  static const LOGIN = _Paths.LOGIN;

  // Home
  static const HOME = _Paths.HOME;

  // Pegawai
  static const PEGAWAI = _Paths.PEGAWAI;

  // Pemilik
  static const PEMILIK = _Paths.PEMILIK;

  // Appointment
  static const APPOINTMENT = _Paths.APPOINTMENT;

  // Hewan
  static const HEWAN = _Paths.HEWAN;

  // Doctor
  static const DOCTOR = _Paths.DOCTOR;

  // Obat
  static const OBAT = _Paths.OBAT;

  // Resep
  static const RESEP = _Paths.RESEP;
  // Pembayaran
  static const ADMIN_PEMBAYARAN = _Paths.ADMIN_PEMBAYARAN;
  static const PEGAWAI_PEMBAYARAN = _Paths.PEGAWAI_PEMBAYARAN;

  static const REKAM_MEDIS = _Paths.REKAM_MEDIS;
  static const PEMBAYARAN = _Paths.PEMBAYARAN;
  static const FORGOTPASS = _Paths.FORGOTPASS;
  static const REGIST = _Paths.REGIST;
  static const PROFILE = _Paths.PROFILE;
  static const PROFILE_PEMILIK = _Paths.PROFILE_PEMILIK;
}

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/dashboard';

  // Home
  static const HOME = '/home';

  // Login
  static const LOGIN = '/login';

  // Pegawai
  static const PEGAWAI = '/pegawai';

  // Pemilik
  static const PEMILIK = '/pemilik';

  // Pemilik
  static const DOCTOR = '/doctor';

  // Hewan
  static const HEWAN = '/hewan';

  // Appointment
  static const APPOINTMENT = '/appointment';

  // Obat
  static const OBAT = '/obat';

  // Resep
  static const RESEP = '/resep';
  // Pembayaran
  static const ADMIN_PEMBAYARAN = '/admin/pembayaran';
  static const PEGAWAI_PEMBAYARAN = '/pegawai/pembayaran';

  static const REKAM_MEDIS = '/rekam-medis';
  static const PEMBAYARAN = '/pembayaran';
  static const FORGOTPASS = '/forgotpass';
  static const REGIST = '/regist';
  static const PROFILE = '/profile';
  static const PROFILE_PEMILIK = '/profile-pemilik';
}

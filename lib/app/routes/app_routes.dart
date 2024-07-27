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
  static const DOKTER = _Paths.DOKTER;

  // Obat
  static const OBAT = _Paths.OBAT;

  // Resep
  static const RESEP = _Paths.RESEP;

  // Pembayaran
  static const PEMBAYARAN = _Paths.PEMBAYARAN;

  // Rekam Medis
  static const REKAM_MEDIS = _Paths.REKAM_MEDIS;

  // Forgot Pass
  static const FORGOTPASS = _Paths.FORGOTPASS;

  // Regis
  static const REGISTER = _Paths.REGISTER;

  // Profile Pegawai
  static const PROFILE_PEGAWAI = _Paths.PROFILE_PEGAWAI;

  // Profil Pemilik
  static const PROFILE_PEMILIK = _Paths.PROFILE_PEMILIK;
  static const PEMILIKHOME = _Paths.PEMILIKHOME;
  static const TENTANG = _Paths.TENTANG;
  static const HARGA = _Paths.HARGA;
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
  static const DOKTER = '/dokter';

  // Hewan
  static const HEWAN = '/hewan';

  // Appointment
  static const APPOINTMENT = '/appointment';

  // Obat
  static const OBAT = '/obat';

  // Resep
  static const RESEP = '/resep';

  // Pembayaran
  static const ADMIN_PEMBAYARAN = '/pembayaran';

  // Rekam Medis
  static const REKAM_MEDIS = '/rekam-medis';

  // Pembayaran
  static const PEMBAYARAN = '/pembayaran';

  // Forgot Pass
  static const FORGOTPASS = '/forgotpass';

  // Register
  static const REGISTER = '/register';

  // Profil Pegawai
  static const PROFILE_PEGAWAI = '/profile-pegawai';

  // Profil Pemilik
  static const PROFILE_PEMILIK = '/profile-pemilik';
  static const PEMILIKHOME = '/pemilikhome';
  static const TENTANG = '/tentang';
  static const HARGA = '/harga';
}

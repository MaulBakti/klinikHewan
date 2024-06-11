part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;

  // Home User
  static const ADMIN_HOME = _Paths.ADMIN_HOME;
  static const PEGAWAI_HOME = _Paths.PEGAWAI_HOME;
  static const PEMILIK_HOME = _Paths.PEMILIK_HOME;

  // Login User
  static const ADMIN_LOGIN = _Paths.ADMIN_LOGIN;
  static const PEGAWAI_LOGIN = _Paths.PEGAWAI_LOGIN;
  static const PEMILIK_LOGIN = _Paths.PEMILIK_LOGIN;

  // Hewan
  static const ADMIN_HEWAN = _Paths.ADMIN_HEWAN;
  static const PEGAWAI_HEWAN = _Paths.PEGAWAI_HEWAN;
  static const PEMILIK_HEWAN = _Paths.PEMILIK_HEWAN;

  // Obat
  static const ADMIN_OBAT = _Paths.ADMIN_OBAT;
  static const PEGAWAI_OBAT = _Paths.PEGAWAI_OBAT;
  static const PEMILIK_OBAT = _Paths.PEMILIK_OBAT;

  // Doctor
  static const ADMIN_DOCTOR = _Paths.ADMIN_DOCTOR;
  static const PEGAWAI_DOCTOR = _Paths.PEGAWAI_DOCTOR;
  static const PEMILIK_DOCTOR = _Paths.PEMILIK_DOCTOR;

  // Pembayaran
  static const ADMIN_PEMBAYARAN = _Paths.ADMIN_PEMBAYARAN;
  static const PEGAWAI_PEMBAYARAN = _Paths.PEGAWAI_PEMBAYARAN;
  static const PEMILIK_PEMBAYARAN = _Paths.PEMILIK_PEMBAYARAN;

  static const PEMILIK = _Paths.PEMILIK;
  static const PEGAWAI = _Paths.PEGAWAI;
  static const REKAM_MEDIS = _Paths.REKAM_MEDIS;
  static const PEMBAYARAN = _Paths.PEMBAYARAN;
}

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/dashboard';

  // Home Admin
  static const ADMIN_HOME = '/adminhome';
  // Pegawai Admin
  static const PEGAWAI_HOME = '/pegawaihome';
  // Pemilik Admin
  static const PEMILIK_HOME = '/pemilikhome';

  // Login Admin
  static const ADMIN_LOGIN = '/admin/login';
  // Login Pegawai
  static const PEGAWAI_LOGIN = '/pegawai/login';
  // Login Pemilik
  static const PEMILIK_LOGIN = '/pemilik/login';

  // Hewan
  static const ADMIN_HEWAN = '/admin/hewan';
  // Pegawai Hewan
  static const PEGAWAI_HEWAN = '/pegawai/hewan';
  // Pemilik Hewan
  static const PEMILIK_HEWAN = '/pemilik/hewan';

  // Obat
  static const ADMIN_OBAT = '/admin/obat';
  static const PEGAWAI_OBAT = '/pegawai/obat';
  static const PEMILIK_OBAT = '/pemilik/obat';

  // Doctor
  static const ADMIN_DOCTOR = '/admin/doctor';
  static const PEGAWAI_DOCTOR = '/pegawai/doctor';
  static const PEMILIK_DOCTOR = '/pemilik/doctor';

  // Pembayaran
  static const ADMIN_PEMBAYARAN = '/admin/pembayaran';
  static const PEGAWAI_PEMBAYARAN = '/pegawai/pembayaran';
  static const PEMILIK_PEMBAYARAN = '/pemilik/pembayaran';

  static const PEMILIK = '/pemilik';
  static const PEGAWAI = '/pegawai';
  static const HEWAN = '/hewan';
  static const REKAM_MEDIS = '/rekam-medis';
  static const PEMBAYARAN = '/pembayaran';
}

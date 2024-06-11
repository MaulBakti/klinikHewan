part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const HOME = _Paths.HOME;

  // Login User
  static const ADMIN_LOGIN = _Paths.ADMIN_LOGIN;
  static const PEGAWAI_LOGIN = _Paths.PEGAWAI_LOGIN;
  static const PEMILIK_LOGIN = _Paths.PEMILIK_LOGIN;

  static const PEMILIK = _Paths.PEMILIK;
  static const PEGAWAI = _Paths.PEGAWAI;
  static const HEWAN = _Paths.HEWAN;
  static const TAMBAH_HEWAN = _Paths.TAMBAH_HEWAN;
  static const REKAM_MEDIS = _Paths.REKAM_MEDIS;
  static const PEMBAYARAN = _Paths.PEMBAYARAN;
}

abstract class _Paths {
  _Paths._();
  static const DASHBOARD = '/dashboard';
  static const HOME = '/home';

  // Login Admin
  static const ADMIN_LOGIN = '/admin/login';
  // Login Pegawai
  static const PEGAWAI_LOGIN = '/pegawai/login';
  // Login Pemilik
  static const PEMILIK_LOGIN = '/pemilik/login';

  static const PEMILIK = '/pemilik';
  static const PEGAWAI = '/pegawai';
  static const HEWAN = '/hewan';
  static const TAMBAH_HEWAN = '/tambah-hewan';
  static const REKAM_MEDIS = '/rekam-medis';
  static const PEMBAYARAN = '/pembayaran';
}

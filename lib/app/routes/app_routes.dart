part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  // Dashboard
  static const DASHBOARD = _Paths.DASHBOARD;

  // Login User
  static const LOGIN = _Paths.LOGIN;

  // Home User
  static const ADMIN_HOME = _Paths.ADMIN_HOME;
  static const PEGAWAI_HOME = _Paths.PEGAWAI_HOME;
  static const PEMILIK_HOME = _Paths.PEMILIK_HOME;

  // Pegawai
  static const PEGAWAI = _Paths.PEGAWAI;

  // Pemilik
  static const PEMILIK = _Paths.PEMILIK;

  // Hewan
  //admin
  static const ADMIN_HEWAN = _Paths.ADMIN_HEWAN;
  // static const ADMIN_TAMBAHHEWAN = _Paths.ADMIN_TAMBAHHEWAN;
  // static const ADMIN_UBAHHEWAN = _Paths.ADMIN_UBAHHEWAN;
  // static const ADMIN_DETAILHEWAN = _Paths.ADMIN_DETAILHEWAN;
  //pegawai
  static const PEGAWAI_HEWAN = _Paths.PEGAWAI_HEWAN;
  // static const PEGAWAI_TAMBAHHEWAN = _Paths.PEGAWAI_TAMBAHHEWAN;
  // static const PEGAWAI_UBAHHEWAN = _Paths.PEGAWAI_UBAHHEWAN;
  // static const PEGAWAI_DETAILHEWAN = _Paths.PEGAWAI_DETAILHEWAN;
  //pemilik
  static const PEMILIK_HEWAN = _Paths.PEMILIK_HEWAN;
  // static const PEMILIK_TAMBAHHEWAN = _Paths.PEMILIK_TAMBAHHEWAN;
  // static const PEMILIK_UBAHHEWAN = _Paths.PEMILIK_UBAHHEWAN;
  // static const PEMILIK_DETAILHEWAN = _Paths.PEMILIK_DETAILHEWAN;

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

  // Login
  static const LOGIN = '/login';

  // Pegawai
  static const PEGAWAI = '/pegawai';

  // Pemilik
  static const PEMILIK = '/pemilik';

  // Hewan
  static const ADMIN_HEWAN = '/admin/hewan';
  // static const ADMIN_TAMBAHHEWAN = '/admin/tambahHewan';
  // static const ADMIN_UBAHHEWAN = '/admin/ubahHewan';
  // static const ADMIN_DETAILHEWAN = '/admin/detailHewan';
  // Pegawai Hewan
  static const PEGAWAI_HEWAN = '/pegawai/hewan';
  // static const PEGAWAI_TAMBAHHEWAN = '/pegawai/tambahHewan';
  // static const PEGAWAI_UBAHHEWAN = '/pegawai/ubahHewan';
  // static const PEGAWAI_DETAILHEWAN = '/pegawai/detailHewan';
  // Pemilik Hewan
  static const PEMILIK_HEWAN = '/pemilik/hewan';
  // static const PEMILIK_TAMBAHHEWAN = '/pemilik/tambahHewan';
  // static const PEMILIK_UBAHHEWAN = '/pemilik/ubahHewan';
  // static const PEMILIK_DETAILHEWAN = '/pemilik/detailHewan';

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

  static const HEWAN = '/hewan';
  static const REKAM_MEDIS = '/rekam-medis';
  static const PEMBAYARAN = '/pembayaran';
}

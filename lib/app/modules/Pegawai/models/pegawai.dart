class Pegawai {
  int idPegawai;
  String namaPegawai;
  String password;
  String jabatan;
  String alamat;
  String noTelp;

  Pegawai({
    required this.idPegawai,
    required this.namaPegawai,
    required this.password,
    required this.jabatan,
    required this.alamat,
    required this.noTelp,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'] ?? 0,
      namaPegawai: json['username'] ?? '',
      password: json['password'] ?? '',
      jabatan: json['jabatan'] ?? '',
      alamat: json['alamat'] ?? '',
      noTelp: json['no_telp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pegawai': idPegawai,
      'username': namaPegawai,
      'password': password,
      'jabatan': jabatan,
      'alamat': alamat,
      'no_telp': noTelp,
    };
  }
}

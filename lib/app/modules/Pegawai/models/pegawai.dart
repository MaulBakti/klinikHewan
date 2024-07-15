class Pegawai {
  int idPegawai;
  String namaPegawai;
  String jabatan;
  String password;
  String alamat;
  String noTelp;

  Pegawai({
    required this.idPegawai,
    required this.namaPegawai,
    required this.jabatan,
    required this.password,
    required this.alamat,
    required this.noTelp,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'] ?? 0,
      namaPegawai: json['username'] ?? '',
      jabatan: json['jabatan'] ?? '',
      password: json['password'] ?? '',
      alamat: json['alamat'] ?? '',
      noTelp: json['no_telp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pegawai': idPegawai,
      'username': namaPegawai,
      'jabatan': jabatan,
      'password': password,
      'alamat': alamat,
      'no_telp': noTelp,
    };
  }
}

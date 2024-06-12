class Pegawai {
  int? id_pegawai;
  String? username;
  String? password;
  String? jabatan;
  String? alamat;
  String? no_telp;

  Pegawai({
    this.id_pegawai,
    this.username,
    this.password,
    this.jabatan,
    this.alamat,
    this.no_telp,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id_pegawai: json['id_pegawai'],
      username: json['username'],
      password: json['password'],
      jabatan: json['jabatan'],
      alamat: json['alamat'],
      no_telp: json['no_telp'],
    );
  }
}

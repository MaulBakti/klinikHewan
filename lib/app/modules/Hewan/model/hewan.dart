class Hewan {
  String? id_hewan;
  String? id_pemilik;
  String? Nama_hewan;
  String? Jenis_hewan;
  String? Umur;
  String? Berat;
  String? Jenis_kelamin;


  Hewan({required this.id_hewan, this.id_pemilik, this.Nama_hewan, this.Jenis_hewan, this.Umur, this.Berat, this.Jenis_kelamin});

  factory Hewan.fromJson(Map<String, dynamic> json) {
    return Hewan(id_hewan: json['id_hewan'],
    id_pemilik: json['id_pemilik'],
    Nama_hewan: json['Nama_hewan'],
    Jenis_hewan: json['Jenis_hewan'],
    Umur: json['Umur'],
    Berat: json['Berat'],
    Jenis_kelamin: json['Jenis_kelamin']
    );
  }
}

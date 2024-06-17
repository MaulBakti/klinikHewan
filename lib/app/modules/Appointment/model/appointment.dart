class Appointment {
  String? id_appointment;
  String? id_hewan;
  String? id_dokter;
  String? tgl_appointment;
  String? catatan;

  Appointment({
    required this.id_appointment,
    this.id_hewan,
    this.id_dokter,
    this.tgl_appointment,
    this.catatan,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id_appointment: json['id_appointment'],
      id_hewan: json['id_hewan'],
      id_dokter: json['id_dokter'],
      tgl_appointment: json['tgl_appointment'],
      catatan: json['catatan'],
    );
  }
}

class Karyawan {
  int? id;
  String nama;
  String jabatan;
  int gajiPokok;
  int tunjangan;
  int potongan;
  int totalGaji;

  Karyawan({
    this.id,
    required this.nama,
    required this.jabatan,
    required this.gajiPokok,
    required this.tunjangan,
    required this.potongan,
  }) : totalGaji = gajiPokok + tunjangan - potongan;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jabatan': jabatan,
      'gajiPokok': gajiPokok,
      'tunjangan': tunjangan,
      'potongan': potongan,
      'totalGaji': totalGaji,
    };
  }
}
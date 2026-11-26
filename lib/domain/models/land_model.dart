class LandModel {
  const LandModel({
    required this.id,
    required this.nomorBidang,
    required this.namaPemilik,
    required this.lokasi,
    required this.luasTanah,
    required this.jenisSertifikat,
    required this.statusDokumen,
    required this.tanggalPenerbitan,
  });

  final String id;
  final String nomorBidang;
  final String namaPemilik;
  final String lokasi;
  final double luasTanah;
  final String jenisSertifikat;
  final String statusDokumen;
  final DateTime tanggalPenerbitan;

  factory LandModel.fromJson(Map<String, dynamic> json) => LandModel(
    id: json['id'] as String,
    nomorBidang: json['nomorBidang'] as String,
    namaPemilik: json['namaPemilik'] as String,
    lokasi: json['lokasi'] as String,
    luasTanah: (json['luasTanah'] as num).toDouble(),
    jenisSertifikat: json['jenisSertifikat'] as String,
    statusDokumen: json['statusDokumen'] as String,
    tanggalPenerbitan: DateTime.parse(json['tanggalPenerbitan'] as String),
  );
}

class BlockchainInfoModel {
  const BlockchainInfoModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.transactionHash,
    required this.tanggal,
    required this.status,
  });

  final String id;
  final String judul;
  final String deskripsi;
  final String transactionHash;
  final DateTime tanggal;
  final String status;

  factory BlockchainInfoModel.fromJson(Map<String, dynamic> json) =>
      BlockchainInfoModel(
        id: json['id'] as String,
        judul: json['judul'] as String,
        deskripsi: json['deskripsi'] as String,
        transactionHash: json['transactionHash'] as String,
        tanggal: DateTime.parse(json['tanggal'] as String),
        status: json['status'] as String,
      );
}

import '../../domain/models/transaksi.dart';

class TransaksiRepository {
  final List<Transaksi> _transaksi = [];

  List<Transaksi> get semuaTransaksi => List.unmodifiable(_transaksi);

  void tambah(Transaksi transaksi) => _transaksi.insert(0, transaksi);

  void hapus(String id) => _transaksi.removeWhere((item) => item.id == id);

  void hapusSemua() => _transaksi.clear();
}

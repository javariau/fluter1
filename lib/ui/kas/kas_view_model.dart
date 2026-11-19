import 'package:flutter/foundation.dart';

import '../../data/repositories/transaksi_repository.dart';
import '../../domain/kas_calculator.dart';
import '../../domain/models/transaksi.dart';

class KasViewModel extends ChangeNotifier {
  final TransaksiRepository repository;
  final KasCalculator calculator;

  KasViewModel({required this.repository, KasCalculator? calculator})
      : calculator = calculator ?? KasCalculator();

  List<Transaksi> get transaksi => repository.semuaTransaksi;
  double get saldo => calculator.hitungSaldo(transaksi);
  double get totalPemasukan => calculator.totalPemasukan(transaksi);
  double get totalPengeluaran => calculator.totalPengeluaran(transaksi);

  String? validasiTransaksi(double nominal, JenisTransaksi jenis) {
    if (nominal <= 0) return 'Nominal harus lebih dari nol';
    if (jenis == JenisTransaksi.pengeluaran && nominal > saldo) {
      return 'Pengeluaran melebihi saldo';
    }
    return null;
  }

  String? tambahTransaksi({
    required String keterangan,
    required double nominal,
    required JenisTransaksi jenis,
  }) {
    final error = validasiTransaksi(nominal, jenis);
    if (error != null) return error;

    repository.tambah(Transaksi(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      keterangan: keterangan,
      nominal: nominal,
      jenis: jenis,
      tanggal: DateTime.now(),
    ));
    notifyListeners();
    return null;
  }

  void hapusTransaksi(String id) {
    repository.hapus(id);
    notifyListeners();
  }
}

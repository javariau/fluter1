import 'package:flutter/foundation.dart';

import '../../data/repositories/blockchain_repository.dart';
import '../../domain/models/blockchain_info_model.dart';

class BlockchainViewModel extends ChangeNotifier {
  BlockchainViewModel(this._repository);

  final BlockchainRepository _repository;
  bool isLoading = false;
  String? error;
  List<BlockchainInfoModel> blockchainInfos = [];
  Future<void>? _loadFuture;

  Future<void> load() =>
      _loadFuture ??= _load().whenComplete(() => _loadFuture = null);

  Future<void> _load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      blockchainInfos = await _repository.getBlockchainInfos();
    } catch (exception) {
      error = 'Riwayat transaksi gagal dimuat. ${exception.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

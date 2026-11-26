import 'package:flutter/foundation.dart';

import '../../data/repositories/land_repository.dart';
import '../../domain/models/land_model.dart';

class LandListViewModel extends ChangeNotifier {
  LandListViewModel(this._repository);

  final LandRepository _repository;
  bool isLoading = false;
  String? error;
  List<LandModel> lands = [];
  String selectedCategory = 'SHM';
  Future<void>? _loadFuture;

  List<LandModel> get filteredLands => lands
      .where((land) => land.jenisSertifikat == selectedCategory)
      .toList(growable: false);

  Future<void> load() =>
      _loadFuture ??= _load().whenComplete(() => _loadFuture = null);

  Future<void> _load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      lands = await _repository.getLands();
    } catch (exception) {
      error = 'Data bidang tanah gagal dimuat. ${exception.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    if (selectedCategory == category) return;
    selectedCategory = category;
    notifyListeners();
  }
}

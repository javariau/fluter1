import 'package:flutter/foundation.dart';

import '../../data/repositories/blockchain_repository.dart';
import '../../data/repositories/land_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/models/blockchain_info_model.dart';
import '../../domain/models/land_model.dart';
import '../../domain/models/task_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(
    this._landRepository,
    this._taskRepository,
    this._blockchainRepository,
  ) {
    _taskRepository.addListener(_onTasksChanged);
  }

  final LandRepository _landRepository;
  final TaskRepository _taskRepository;
  final BlockchainRepository _blockchainRepository;

  bool isLoading = false;
  String? error;
  List<LandModel> lands = [];
  List<BlockchainInfoModel> blockchainInfos = [];
  List<TaskModel> get pendingTasks => _taskRepository.pendingTasks;
  Future<void>? _loadFuture;

  Future<void> load() =>
      _loadFuture ??= _load().whenComplete(() => _loadFuture = null);

  Future<void> _load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        _landRepository.getLands(),
        _taskRepository.getTasks(),
        _blockchainRepository.getBlockchainInfos(),
      ]);
      lands = results[0] as List<LandModel>;
      blockchainInfos = results[2] as List<BlockchainInfoModel>;
    } catch (exception) {
      error = 'Data beranda gagal dimuat. ${exception.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _onTasksChanged() => notifyListeners();

  @override
  void dispose() {
    _taskRepository.removeListener(_onTasksChanged);
    super.dispose();
  }
}

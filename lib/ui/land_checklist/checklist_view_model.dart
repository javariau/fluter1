import 'package:flutter/foundation.dart';

import '../../data/repositories/task_repository.dart';
import '../../domain/models/task_model.dart';

class ChecklistViewModel extends ChangeNotifier {
  ChecklistViewModel(this._repository) {
    _repository.addListener(_onTasksChanged);
  }

  final TaskRepository _repository;
  bool isLoading = false;
  String? error;
  List<TaskModel> get pendingTasks => _repository.pendingTasks;
  List<TaskModel> get completedTasks => _repository.completedTasks;
  Future<void>? _loadFuture;

  Future<void> load() =>
      _loadFuture ??= _load().whenComplete(() => _loadFuture = null);

  Future<void> _load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.getTasks();
    } catch (exception) {
      error = 'Checklist gagal dimuat. ${exception.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleTask(String id) => _repository.toggleTask(id);

  void _onTasksChanged() => notifyListeners();

  @override
  void dispose() {
    _repository.removeListener(_onTasksChanged);
    super.dispose();
  }
}

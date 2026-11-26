import 'package:flutter/foundation.dart';

import '../../domain/models/task_model.dart';
import '../services/landchain_service.dart';

class TaskRepository extends ChangeNotifier {
  TaskRepository(this._service);

  final LandChainService _service;
  List<TaskModel> _tasks = [];
  bool _hasLoaded = false;
  Future<List<TaskModel>>? _loadFuture;

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList(growable: false);
  List<TaskModel> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList(growable: false);

  Future<List<TaskModel>> getTasks() {
    if (_hasLoaded) return Future.value(tasks);
    return _loadFuture ??= _service
        .getTasks()
        .then((items) {
          _tasks = items;
          _hasLoaded = true;
          notifyListeners();
          return tasks;
        })
        .whenComplete(() => _loadFuture = null);
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index < 0) return;
    _tasks[index] = _tasks[index].copyWith(
      isCompleted: !_tasks[index].isCompleted,
    );
    notifyListeners();
  }
}

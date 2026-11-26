import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ui_helpers.dart';
import 'checklist_view_model.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  late final ChecklistViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<ChecklistViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _viewModel.load();
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _viewModel,
    builder: (context, _) {
      if (_viewModel.isLoading &&
          _viewModel.pendingTasks.isEmpty &&
          _viewModel.completedTasks.isEmpty) {
        return loadingState();
      }
      if (_viewModel.error != null &&
          _viewModel.pendingTasks.isEmpty &&
          _viewModel.completedTasks.isEmpty) {
        return errorState(_viewModel.error!, _viewModel.load);
      }
      if (_viewModel.pendingTasks.isEmpty &&
          _viewModel.completedTasks.isEmpty) {
        return emptyState('Belum ada checklist pengurusan.');
      }
      return ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          _ChecklistProgress(
            completed: _viewModel.completedTasks.length,
            total:
                _viewModel.completedTasks.length +
                _viewModel.pendingTasks.length,
          ),
          const SizedBox(height: 22),
          SectionTitle('Belum selesai (${_viewModel.pendingTasks.length})'),
          if (_viewModel.pendingTasks.isEmpty)
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Text(
                'Semua tahap pengurusan sudah selesai.',
                style: TextStyle(color: Color(0xFF738391)),
              ),
            )
          else
            ..._viewModel.pendingTasks.map(
              (task) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: CheckboxListTile(
                  value: false,
                  onChanged: (_) => _viewModel.toggleTask(task.id),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    task.judul,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('${task.deskripsi}\n${task.kategori}'),
                  isThreeLine: true,
                  activeColor: const Color(0xFF16856B),
                ),
              ),
            ),
          const SizedBox(height: 14),
          SectionTitle('Selesai (${_viewModel.completedTasks.length})'),
          if (_viewModel.completedTasks.isEmpty)
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Text(
                'Item yang selesai akan tampil di sini.',
                style: TextStyle(color: Color(0xFF738391)),
              ),
            )
          else
            ..._viewModel.completedTasks.map(
              (task) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: CheckboxListTile(
                  value: true,
                  onChanged: (_) => _viewModel.toggleTask(task.id),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    task.judul,
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Color(0xFF738391),
                    ),
                  ),
                  subtitle: Text('${task.deskripsi}\n${task.kategori}'),
                  isThreeLine: true,
                  activeColor: const Color(0xFF16856B),
                ),
              ),
            ),
        ],
      );
    },
  );
}

class _ChecklistProgress extends StatelessWidget {
  const _ChecklistProgress({required this.completed, required this.total});

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Progres pengurusan',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF12304A),
                    ),
                  ),
                ),
                Text(
                  '$completed/$total',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF16856B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFE7ECEF),
                color: const Color(0xFF16856B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

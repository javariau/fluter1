import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/ui_helpers.dart';
import 'land_card.dart';
import 'land_list_view_model.dart';

class LandListScreen extends StatefulWidget {
  const LandListScreen({super.key});

  @override
  State<LandListScreen> createState() => _LandListScreenState();
}

class _LandListScreenState extends State<LandListScreen> {
  late final LandListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<LandListViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _viewModel.load();
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _viewModel,
    builder: (context, _) {
      if (_viewModel.isLoading && _viewModel.lands.isEmpty) {
        return loadingState();
      }
      if (_viewModel.error != null && _viewModel.lands.isEmpty) {
        return errorState(_viewModel.error!, _viewModel.load);
      }
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'SHM', label: Text('SHM')),
                ButtonSegment(value: 'HGB', label: Text('HGB')),
                ButtonSegment(value: 'AJB', label: Text('AJB')),
              ],
              selected: {_viewModel.selectedCategory},
              onSelectionChanged: (value) =>
                  _viewModel.selectCategory(value.first),
            ),
          ),
          Expanded(
            child: _viewModel.filteredLands.isEmpty
                ? emptyState(
                    'Belum ada bidang dengan sertifikat ${_viewModel.selectedCategory}.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: _viewModel.filteredLands.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) =>
                        LandCard(land: _viewModel.filteredLands[index]),
                  ),
          ),
        ],
      );
    },
  );
}

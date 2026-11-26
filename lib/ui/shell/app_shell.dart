import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/blockchain_repository.dart';
import '../../data/repositories/land_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../blockchain/blockchain_screen.dart';
import '../blockchain/blockchain_view_model.dart';
import '../home/home_screen.dart';
import '../home/home_view_model.dart';
import '../land_checklist/checklist_screen.dart';
import '../land_checklist/checklist_view_model.dart';
import '../land_list/land_list_screen.dart';
import '../land_list/land_list_view_model.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      ChangeNotifierProvider(
        create: (context) => HomeViewModel(
          context.read<LandRepository>(),
          context.read<TaskRepository>(),
          context.read<BlockchainRepository>(),
        ),
        child: HomeScreen(
          onOpenLands: () => setState(() => _selectedIndex = 1),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => LandListViewModel(context.read<LandRepository>()),
        child: const LandListScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChecklistViewModel(context.read<TaskRepository>()),
        child: const ChecklistScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            BlockchainViewModel(context.read<BlockchainRepository>()),
        child: const BlockchainScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _selectedIndex == 0
        ? null
        : AppBar(
            title: Text(
              [
                'Beranda',
                'Data Tanah',
                'Checklist',
                'Blockchain',
              ][_selectedIndex],
            ),
          ),
    body: IndexedStack(index: _selectedIndex, children: _screens),
    bottomNavigationBar: ListenableBuilder(
      listenable: context.watch<TaskRepository>(),
      builder: (context, _) => NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.space_dashboard_outlined),
            selectedIcon: Icon(Icons.space_dashboard),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Data Tanah',
          ),
          NavigationDestination(
            icon: _ChecklistIcon(
              count: context.watch<TaskRepository>().pendingTasks.length,
            ),
            selectedIcon: _ChecklistIcon(
              count: context.watch<TaskRepository>().pendingTasks.length,
              selected: true,
            ),
            label: 'Checklist',
          ),
          const NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Blockchain',
          ),
        ],
      ),
    ),
  );
}

class _ChecklistIcon extends StatelessWidget {
  const _ChecklistIcon({required this.count, this.selected = false});

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) => Badge(
    isLabelVisible: count > 0,
    label: Text('$count'),
    child: Icon(selected ? Icons.checklist : Icons.checklist_outlined),
  );
}

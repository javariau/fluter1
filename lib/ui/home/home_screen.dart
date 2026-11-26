import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/task_model.dart';
import '../core/ui_helpers.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.onOpenLands, super.key});

  final VoidCallback? onOpenLands;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<HomeViewModel>();
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
      if (_viewModel.lands.isEmpty) {
        return emptyState('Belum ada data bidang tanah.');
      }
      final lands = [..._viewModel.lands]
        ..sort((a, b) => b.tanggalPenerbitan.compareTo(a.tanggalPenerbitan));
      final pending = _viewModel.pendingTasks;
      final latestTx = _viewModel.blockchainInfos.isEmpty
          ? null
          : _viewModel.blockchainInfos.first;
      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LANDCHAIN',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: Color(0xFF16856B),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Selamat pagi, Bintang',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF12304A),
                            ),
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFFE0F1EA),
                  foregroundColor: Color(0xFF12304A),
                  child: Icon(Icons.person_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _PortfolioBanner(total: lands.length, pending: pending.length),
            const SizedBox(height: 22),
            const SectionTitle('Ringkasan sertifikat'),
            Row(
              children: [
                for (final type in ['SHM', 'HGB', 'AJB'])
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: type == 'AJB' ? 0 : 9),
                      child: _TypeCount(
                        type: type,
                        count: lands
                            .where((land) => land.jenisSertifikat == type)
                            .length,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            SectionTitle(
              'Bidang terbaru',
              action: 'Lihat semua',
              onAction: widget.onOpenLands,
            ),
            ...lands
                .take(3)
                .map(
                  (land) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEAF0F4),
                          child: Icon(
                            Icons.landscape_outlined,
                            color: Color(0xFF12304A),
                          ),
                        ),
                        title: Text(
                          land.nomorBidang,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${land.namaPemilik} · ${land.lokasi}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: StatusPill(land.jenisSertifikat),
                      ),
                    ),
                  ),
                ),
            const SizedBox(height: 12),
            SectionTitle(
              'Perlu diselesaikan',
              action: '${pending.length} item',
            ),
            if (pending.isEmpty)
              const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF16856B),
                  ),
                  title: Text('Semua checklist selesai'),
                ),
              )
            else
              ...pending.take(3).map(_PendingTaskTile.new),
            const SizedBox(height: 20),
            const SectionTitle('Aktivitas ledger'),
            if (latestTx == null)
              const Card(child: ListTile(title: Text('Belum ada transaksi.')))
            else
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE0F1EA),
                    child: Icon(
                      Icons.verified_outlined,
                      color: Color(0xFF16856B),
                    ),
                  ),
                  title: Text(
                    latestTx.judul,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    '${latestTx.id} · ${formatDate(latestTx.tanggal)}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                ),
              ),
          ],
        ),
      );
    },
  );
}

class _PortfolioBanner extends StatelessWidget {
  const _PortfolioBanner({required this.total, required this.pending});

  final int total;
  final int pending;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF12304A),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TOTAL BIDANG TANAH',
                style: TextStyle(
                  color: Color(0xFFB9D2DC),
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '$total',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$pending checklist menunggu',
                style: const TextStyle(color: Color(0xFFB9D2DC), fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.account_balance_outlined,
            color: Color(0xFF8EE0BE),
            size: 28,
          ),
        ),
      ],
    ),
  );
}

class _TypeCount extends StatelessWidget {
  const _TypeCount({required this.type, required this.count});

  final String type;
  final int count;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Text(
            type,
            style: const TextStyle(
              color: Color(0xFF738391),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$count',
            style: const TextStyle(
              color: Color(0xFF12304A),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );
}

class _PendingTaskTile extends StatelessWidget {
  const _PendingTaskTile(this.task);

  final TaskModel task;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      dense: true,
      leading: const Icon(
        Icons.radio_button_unchecked,
        color: Color(0xFF16856B),
      ),
      title: Text(task.judul),
      subtitle: Text(task.kategori),
    ),
  );
}

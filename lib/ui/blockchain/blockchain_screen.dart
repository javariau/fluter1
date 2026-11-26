import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/blockchain_info_model.dart';
import '../core/ui_helpers.dart';
import 'blockchain_view_model.dart';

class BlockchainScreen extends StatefulWidget {
  const BlockchainScreen({super.key});

  @override
  State<BlockchainScreen> createState() => _BlockchainScreenState();
}

class _BlockchainScreenState extends State<BlockchainScreen> {
  late final BlockchainViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<BlockchainViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _viewModel.load();
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _viewModel,
    builder: (context, _) {
      if (_viewModel.isLoading && _viewModel.blockchainInfos.isEmpty) {
        return loadingState();
      }
      if (_viewModel.error != null && _viewModel.blockchainInfos.isEmpty) {
        return errorState(_viewModel.error!, _viewModel.load);
      }
      if (_viewModel.blockchainInfos.isEmpty) {
        return emptyState('Belum ada riwayat transaksi.');
      }
      return ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF12304A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.hub_outlined, color: Color(0xFF8EE0BE), size: 30),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LANDCHAIN EXPLORER',
                        style: TextStyle(
                          color: Color(0xFFB9D2DC),
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Ledger verifikasi dokumen',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const SectionTitle('Riwayat transaksi'),
          ..._viewModel.blockchainInfos.asMap().entries.map(
            (entry) => _TransactionTile(
              info: entry.value,
              isLast: entry.key == _viewModel.blockchainInfos.length - 1,
            ),
          ),
        ],
      );
    },
  );
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.info, required this.isLast});

  final BlockchainInfoModel info;
  final bool isLast;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F1EA),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.link,
                  size: 15,
                  color: Color(0xFF16856B),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFDCE5E9)),
                ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          info.judul,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF12304A),
                          ),
                        ),
                      ),
                      StatusPill(info.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    info.deskripsi,
                    style: const TextStyle(
                      color: Color(0xFF586875),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'TRANSACTION HASH',
                    style: TextStyle(
                      color: Color(0xFF738391),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    info.transactionHash,
                    style: const TextStyle(
                      color: Color(0xFF16856B),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        info.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formatDate(info.tanggal),
                        style: const TextStyle(
                          color: Color(0xFF738391),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

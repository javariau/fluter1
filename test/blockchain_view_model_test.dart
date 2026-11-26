import 'package:flutter_test/flutter_test.dart';
import 'package:landchain/data/repositories/blockchain_repository.dart';
import 'package:landchain/data/services/landchain_service.dart';
import 'package:landchain/domain/models/blockchain_info_model.dart';
import 'package:landchain/ui/blockchain/blockchain_view_model.dart';

class _FakeBlockchainRepository extends BlockchainRepository {
  _FakeBlockchainRepository({this.shouldFail = false})
    : super(LandChainService());

  final bool shouldFail;

  @override
  Future<List<BlockchainInfoModel>> getBlockchainInfos() async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    if (shouldFail) throw Exception('network unavailable');
    return [
      BlockchainInfoModel(
        id: 'TX-TEST',
        judul: 'Dokumen diverifikasi',
        deskripsi: 'Verifikasi berhasil.',
        transactionHash: '0xabc123',
        tanggal: DateTime(2025, 10, 18),
        status: 'Terkonfirmasi',
      ),
    ];
  }
}

void main() {
  test('loads blockchain data and resets loading state', () async {
    final viewModel = BlockchainViewModel(_FakeBlockchainRepository());
    final loadingStates = <bool>[];
    viewModel.addListener(() => loadingStates.add(viewModel.isLoading));

    final load = viewModel.load();
    expect(viewModel.isLoading, isTrue);
    await load;

    expect(viewModel.isLoading, isFalse);
    expect(viewModel.error, isNull);
    expect(viewModel.blockchainInfos, hasLength(1));
    expect(viewModel.blockchainInfos.single.transactionHash, '0xabc123');
    expect(loadingStates, containsAllInOrder([true, false]));
    viewModel.dispose();
  });

  test(
    'exposes an error and resets loading state when repository fails',
    () async {
      final viewModel = BlockchainViewModel(
        _FakeBlockchainRepository(shouldFail: true),
      );

      await viewModel.load();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, contains('network unavailable'));
      expect(viewModel.blockchainInfos, isEmpty);
      viewModel.dispose();
    },
  );
}

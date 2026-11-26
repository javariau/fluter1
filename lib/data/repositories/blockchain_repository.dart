import '../../domain/models/blockchain_info_model.dart';
import '../services/landchain_service.dart';

class BlockchainRepository {
  BlockchainRepository(this._service);

  final LandChainService _service;

  Future<List<BlockchainInfoModel>> getBlockchainInfos() =>
      _service.getBlockchainInfos();
}

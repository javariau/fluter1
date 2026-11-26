import '../../domain/models/land_model.dart';
import '../services/landchain_service.dart';

class LandRepository {
  LandRepository(this._service);

  final LandChainService _service;

  Future<List<LandModel>> getLands() => _service.getLands();
}

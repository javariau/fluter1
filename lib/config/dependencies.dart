import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/repositories/blockchain_repository.dart';
import '../data/repositories/land_repository.dart';
import '../data/repositories/task_repository.dart';
import '../data/services/landchain_service.dart';

class LandChainDependencies extends StatelessWidget {
  const LandChainDependencies({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<LandChainService>(create: (_) => LandChainService()),
      Provider<LandRepository>(
        create: (context) => LandRepository(context.read<LandChainService>()),
      ),
      ChangeNotifierProvider<TaskRepository>(
        create: (context) => TaskRepository(context.read<LandChainService>()),
      ),
      Provider<BlockchainRepository>(
        create: (context) =>
            BlockchainRepository(context.read<LandChainService>()),
      ),
    ],
    child: child,
  );
}

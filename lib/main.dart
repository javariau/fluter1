import 'package:flutter/material.dart';

import 'data/repositories/transaksi_repository.dart';
import 'ui/kas/home_screen.dart';
import 'ui/kas/kas_view_model.dart';

void main() {
  runApp(const NusaKasApp());
}

class NusaKasApp extends StatelessWidget {
  const NusaKasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = KasViewModel(repository: TransaksiRepository());
    return MaterialApp(
      title: 'NusaKas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF287A67)),
      ),
      home: HomeScreen(viewModel: viewModel),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';
import 'tambah_transaksi_screen.dart';

class HomeScreen extends StatefulWidget {
  final KasViewModel viewModel;
  const HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formatRupiah = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    widget.viewModel.removeListener(_refresh);
    super.dispose();
  }

  Future<void> _tambah() async {
    await Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => TambahTransaksiScreen(viewModel: widget.viewModel),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;
    return Scaffold(
      appBar: AppBar(title: const Text('NusaKas'), centerTitle: true),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(children: [
              const Text('Saldo Kas'),
              Text(formatRupiah.format(vm.saldo), key: const Key('saldo'), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(children: [const Text('Pemasukan'), Text(formatRupiah.format(vm.totalPemasukan), key: const Key('total_pemasukan'), style: const TextStyle(color: Colors.green))]),
                Column(children: [const Text('Pengeluaran'), Text(formatRupiah.format(vm.totalPengeluaran), key: const Key('total_pengeluaran'), style: const TextStyle(color: Colors.red))]),
              ]),
            ]),
          ),
        ),
        Expanded(child: vm.transaksi.isEmpty
            ? const Center(key: Key('daftar_kosong'), child: Text('Belum ada transaksi'))
            : ListView.builder(
                key: const Key('daftar_transaksi'),
                itemCount: vm.transaksi.length,
                itemBuilder: (_, index) {
                  final item = vm.transaksi[index];
                  final masuk = item.jenis == JenisTransaksi.pemasukan;
                  return Dismissible(
                    key: Key(item.id),
                    background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => vm.hapusTransaksi(item.id),
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(masuk ? Icons.arrow_downward : Icons.arrow_upward, color: masuk ? Colors.green : Colors.red)),
                      title: Text(item.keterangan),
                      subtitle: Text('${item.tanggal.day}/${item.tanggal.month}/${item.tanggal.year}'),
                      trailing: Text('${masuk ? '+' : '-'}${formatRupiah.format(item.nominal)}', style: TextStyle(color: masuk ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              )),
      ]),
      floatingActionButton: FloatingActionButton(
        key: const Key('tombol_tambah'),
        onPressed: _tambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}

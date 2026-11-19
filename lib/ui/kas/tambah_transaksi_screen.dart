import 'package:flutter/material.dart';

import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';

class TambahTransaksiScreen extends StatefulWidget {
  final KasViewModel viewModel;
  const TambahTransaksiScreen({super.key, required this.viewModel});

  @override
  State<TambahTransaksiScreen> createState() => _TambahTransaksiScreenState();
}

class _TambahTransaksiScreenState extends State<TambahTransaksiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keteranganController = TextEditingController();
  final _nominalController = TextEditingController();
  JenisTransaksi _jenis = JenisTransaksi.pemasukan;

  @override
  void dispose() {
    _keteranganController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final nominal = double.parse(_nominalController.text.replaceAll(',', '.'));
    final error = widget.viewModel.tambahTransaksi(
      keterangan: _keteranganController.text.trim(),
      nominal: nominal,
      jenis: _jenis,
    );
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Transaksi')),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          TextFormField(
            key: const Key('field_keterangan'),
            controller: _keteranganController,
            decoration: const InputDecoration(labelText: 'Keterangan'),
            validator: (value) => value == null || value.trim().isEmpty ? 'Keterangan wajib diisi' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const Key('field_nominal'),
            controller: _nominalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nominal'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Nominal wajib diisi';
              final nominal = double.tryParse(value.replaceAll(',', '.'));
              if (nominal == null) return 'Nominal tidak valid';
              if (nominal <= 0) return 'Nominal harus lebih dari nol';
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<JenisTransaksi>(
            key: const Key('field_jenis'),
            initialValue: _jenis,
            decoration: const InputDecoration(labelText: 'Jenis'),
            items: const [
              DropdownMenuItem(value: JenisTransaksi.pemasukan, child: Text('Pemasukan')),
              DropdownMenuItem(value: JenisTransaksi.pengeluaran, child: Text('Pengeluaran')),
            ],
            onChanged: (value) => setState(() => _jenis = value!),
          ),
          const SizedBox(height: 24),
          FilledButton(key: const Key('tombol_simpan'), onPressed: _simpan, child: const Text('Simpan')),
        ]),
      ),
    );
  }
}

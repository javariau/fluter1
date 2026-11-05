import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  const EventRegistrationScreen({super.key, required this.event, required this.onRegistered});

  final EventItem event;
  final ValueChanged<RegistrationTicket> onRegistered;

  @override
  State<EventRegistrationScreen> createState() => _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  String _participantType = 'Mahasiswa';
  DateTime? _attendanceDate;
  bool _seminarKit = true;
  bool _rulesAccepted = false;
  int _donation = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final today = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _attendanceDate ?? DateTime(2026, 11, 18),
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(2026, 11, 21),
      helpText: 'Pilih tanggal kehadiran',
      cancelText: 'BATAL',
      confirmText: 'PILIH',
      selectableDayPredicate: (date) => date.isAfter(DateTime(2026, 11, 17)) && date.isBefore(DateTime(2026, 11, 22)),
    );
    if (selected != null) setState(() => _attendanceDate = selected);
  }

  String? _required(String? value, String label) => value == null || value.trim().isEmpty ? '$label wajib diisi' : null;

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    if (_attendanceDate == null || !_rulesAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih tanggal dan setujui tata tertib terlebih dahulu.')));
      return;
    }
    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    final ticket = RegistrationTicket(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      event: widget.event,
      name: _nameController.text.trim(),
      nim: _nimController.text.trim(),
      email: _emailController.text.trim(),
      whatsapp: _whatsappController.text.trim(),
      participantType: _participantType,
      attendanceDate: _attendanceDate!,
      seminarKit: _seminarKit,
      donation: _donation,
    );
    widget.onRegistered(ticket);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Formulir pendaftaran', style: TextStyle(fontWeight: FontWeight.w800))),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: [
                    _EventSummary(event: widget.event),
                    const SizedBox(height: 22),
                    const _SectionLabel('DATA PESERTA'),
                    const SizedBox(height: 12),
                    TextFormField(controller: _nameController, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nama lengkap', prefixIcon: Icon(Icons.person_outline)), validator: (value) => _required(value, 'Nama')),
                    const SizedBox(height: 11),
                    TextFormField(controller: _nimController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'NIM', prefixIcon: Icon(Icons.badge_outlined)), validator: (value) {
                      final required = _required(value, 'NIM');
                      if (required != null) return required;
                      return RegExp(r'^\d{6,15}$').hasMatch(value!.trim()) ? null : 'NIM harus berupa 6–15 digit angka';
                    }),
                    const SizedBox(height: 11),
                    TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline)), validator: (value) {
                      final required = _required(value, 'Email');
                      if (required != null) return required;
                      return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value!.trim()) ? null : 'Masukkan alamat email yang valid';
                    }),
                    const SizedBox(height: 11),
                    TextFormField(controller: _whatsappController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Nomor WhatsApp', prefixIcon: Icon(Icons.phone_android_outlined), hintText: '08xxxxxxxxxx'), validator: (value) {
                      final required = _required(value, 'Nomor WhatsApp');
                      if (required != null) return required;
                      return RegExp(r'^[+0-9][0-9\s-]{8,15}$').hasMatch(value!.trim()) ? null : 'Masukkan nomor WhatsApp yang valid';
                    }),
                    const SizedBox(height: 11),
                    DropdownButtonFormField<String>(
                      initialValue: _participantType,
                      isExpanded: true,
                      decoration: const InputDecoration(labelText: 'Tipe peserta', prefixIcon: Icon(Icons.groups_outlined)),
                      items: const [DropdownMenuItem(value: 'Mahasiswa', child: Text('Mahasiswa')), DropdownMenuItem(value: 'Umum', child: Text('Umum')), DropdownMenuItem(value: 'Dosen', child: Text('Dosen'))],
                      onChanged: (value) => setState(() => _participantType = value ?? 'Mahasiswa'),
                    ),
                    const SizedBox(height: 22),
                    const _SectionLabel('PREFERENSI KEHADIRAN'),
                    const SizedBox(height: 11),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      onPressed: _selectDate,
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: Text(_attendanceDate == null ? 'Pilih tanggal kehadiran' : '${_attendanceDate!.day}/${_attendanceDate!.month}/${_attendanceDate!.year}'),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                      title: const Text('Paket seminar kit', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: const Text('Notebook, tote bag, dan merchandise acara'),
                      value: _seminarKit,
                      onChanged: (value) => setState(() => _seminarKit = value),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      initialValue: _donation,
                      isExpanded: true,
                      decoration: const InputDecoration(labelText: 'Donasi opsional', prefixIcon: Icon(Icons.volunteer_activism_outlined)),
                      items: const [DropdownMenuItem(value: 0, child: Text('Tidak berdonasi')), DropdownMenuItem(value: 10000, child: Text('Rp10.000')), DropdownMenuItem(value: 25000, child: Text('Rp25.000')), DropdownMenuItem(value: 50000, child: Text('Rp50.000'))],
                      onChanged: (value) => setState(() => _donation = value ?? 0),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _rulesAccepted,
                      onChanged: (value) => setState(() => _rulesAccepted = value ?? false),
                      title: const Text('Saya menyetujui tata tertib acara', style: TextStyle(fontSize: 13)),
                      subtitle: const Text('Datang sesuai jadwal dan menjaga kenyamanan bersama.', style: TextStyle(fontSize: 11)),
                    ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: _isSubmitting ? null : _submit,
                      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      icon: _isSubmitting ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.confirmation_num_outlined),
                      label: Text(_isSubmitting ? 'Menyimpan pendaftaran...' : 'Daftar • Rp${widget.event.price ~/ 1000}k', style: const TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _EventSummary extends StatelessWidget {
  const _EventSummary({required this.event});

  final EventItem event;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(color: const Color(0xFF172321), borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(event.category.toUpperCase(), style: const TextStyle(color: Color(0xFFCAEF63), fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1.2)), const SizedBox(height: 7), Text(event.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)), const SizedBox(height: 8), Text('${event.dateLabel}  •  ${event.venue}', style: const TextStyle(color: Color(0xFFD4DCD7), fontSize: 12))]),
      );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Text(label, style: const TextStyle(fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w800, color: Color(0xFF75807A)));
}
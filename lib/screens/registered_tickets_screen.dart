import 'package:flutter/material.dart';

import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  const RegisteredTicketsScreen({super.key, required this.tickets, required this.onCancel});

  final List<RegistrationTicket> tickets;
  final ValueChanged<RegistrationTicket> onCancel;

  Future<void> _confirmCancel(BuildContext context, RegistrationTicket ticket) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: Color(0xFFE56B4B), size: 32),
        title: const Text('Batalkan tiket?'),
        content: Text('Pendaftaran untuk "${ticket.event.title}" akan dihapus dari daftar tiket aktif.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Kembali')),
          FilledButton.tonal(onPressed: () => Navigator.pop(context, true), child: const Text('Ya, batalkan')),
        ],
      ),
    );
    if (confirmed == true) onCancel(ticket);
  }

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: tickets.isEmpty
              ? ListView(padding: const EdgeInsets.fromLTRB(22, 18, 22, 20), children: [const Text('KENDALI PENDAFTARAN', style: TextStyle(color: Color(0xFF75807A), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)), const SizedBox(height: 3), const Text('Tiket Terdaftar', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)), const SizedBox(height: 90), const Icon(Icons.confirmation_number_outlined, size: 52, color: Color(0xFF9AA49E)), const SizedBox(height: 14), const Text('Belum ada tiket aktif', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)), const SizedBox(height: 6), const Text('Pilih seminar dan selesaikan pendaftaran untuk menyimpan tiketmu di sini.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF75807A), height: 1.4))])
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                  itemCount: tickets.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) return const Padding(padding: EdgeInsets.only(bottom: 17), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('KENDALI PENDAFTARAN', style: TextStyle(color: Color(0xFF75807A), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)), SizedBox(height: 3), Text('Tiket Terdaftar', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800))]));
                    final ticket = tickets[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Dismissible(
                        key: ValueKey(ticket.id),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          await _confirmCancel(context, ticket);
                          return false;
                        },
                        background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), decoration: BoxDecoration(color: const Color(0xFFE56B4B), borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.delete_outline, color: Colors.white)),
                        child: _TicketCard(ticket: ticket),
                      ),
                    );
                  },
                ),
        ),
      );
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.ticket});

  final RegistrationTicket ticket;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, runSpacing: 6, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFCAEF63), borderRadius: BorderRadius.circular(18)), child: Text(ticket.event.category, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800))), const Icon(Icons.verified_rounded, color: Color(0xFF64812D), size: 18), const Text('AKTIF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8))]),
            const SizedBox(height: 11),
            Text(ticket.event.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, height: 1.2)),
            const SizedBox(height: 13),
            _detail(Icons.person_outline, ticket.name),
            const SizedBox(height: 6),
            _detail(Icons.calendar_today_outlined, '${ticket.attendanceDate.day}/${ticket.attendanceDate.month}/${ticket.attendanceDate.year} • ${ticket.event.time}'),
            const SizedBox(height: 6),
            _detail(Icons.place_outlined, ticket.event.venue),
            const SizedBox(height: 14),
            Container(height: 1, color: const Color(0xFFE8EAE5)),
            const SizedBox(height: 11),
            Row(children: [Text('ID ${ticket.id.substring(ticket.id.length - 8)}', style: const TextStyle(color: Color(0xFF75807A), fontSize: 11, fontWeight: FontWeight.w700)), const Spacer(), Text('Rp${ticket.event.price ~/ 1000}k', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14))]),
          ],
        ),
      );

  Widget _detail(IconData icon, String label) => Row(children: [Icon(icon, size: 15, color: const Color(0xFF75807A)), const SizedBox(width: 7), Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF59645E))))]);
}
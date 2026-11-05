import 'package:flutter/material.dart';

import '../models/event_item.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, required this.onTap});

  final EventItem event;
  final VoidCallback onTap;

  Color get _accent => switch (event.category) {
        'AI' => const Color(0xFFCAEF63),
        'Mobile' => const Color(0xFFFFC45B),
        'IoT' => const Color(0xFF8FD3C8),
        _ => const Color(0xFFE7A6B6),
      };

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: _accent, borderRadius: BorderRadius.circular(20)),
                      child: Text(event.category, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                    ),
                    Text(event.dateLabel, style: const TextStyle(fontSize: 11, letterSpacing: 0.6, fontWeight: FontWeight.w700, color: Color(0xFF6C7773))),
                  ],
                ),
                const SizedBox(height: 13),
                Text(event.title, style: const TextStyle(fontSize: 17, height: 1.2, fontWeight: FontWeight.w800, color: Color(0xFF172321))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.schedule_rounded, size: 15, color: Color(0xFF68736F)),
                    const SizedBox(width: 5),
                    Expanded(child: Text(event.time, style: const TextStyle(fontSize: 12, color: Color(0xFF68736F)))),
                    const Icon(Icons.place_outlined, size: 15, color: Color(0xFF68736F)),
                    const SizedBox(width: 3),
                    Flexible(child: Text(event.venue, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF68736F)))),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text('Rp${event.price ~/ 1000}k', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(width: 8),
                    Expanded(child: Text('${event.seatsLeft} kursi tersisa', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF68736F)))),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
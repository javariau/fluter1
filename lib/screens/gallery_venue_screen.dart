import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../widgets/venue_map_viewer.dart';

class GalleryVenueScreen extends StatelessWidget {
  const GalleryVenueScreen({super.key, required this.events});

  final List<EventItem> events;

  static const _colors = [Color(0xFF172321), Color(0xFFE56B4B), Color(0xFF597C78), Color(0xFF354747), Color(0xFFB36A52), Color(0xFF557B5C)];

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 18, 20, 16),
                sliver: SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('SUASANA ACARA', style: TextStyle(color: Color(0xFF75807A), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)), SizedBox(height: 3), Text('Galeri & Denah Venue', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800))])),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid.builder(
                  itemCount: events.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.83),
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _Poster(event: event, color: _colors[index % _colors.length]);
                  },
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 11),
                sliver: SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('TEMUKAN RUANGMU', style: TextStyle(color: Color(0xFF75807A), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)), SizedBox(height: 3), Text('Denah Gedung Nusa', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800))])),
              ),
              const SliverPadding(padding: EdgeInsets.fromLTRB(20, 0, 20, 30), sliver: SliverToBoxAdapter(child: VenueMapViewer())),
            ],
          ),
        ),
      );
}

class _Poster extends StatelessWidget {
  const _Poster({required this.event, required this.color});

  final EventItem event;
  final Color color;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: color),
            Positioned(right: -22, top: -25, child: Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.18), width: 22)))),
            Positioned(left: 14, top: 16, child: Text('NUSAEVENT\nHUB 2026', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 9, height: 1.3, fontWeight: FontWeight.w800, letterSpacing: 1.2))),
            Positioned(left: 14, right: 12, bottom: 16, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFCAEF63), borderRadius: BorderRadius.circular(12)), child: Text(event.category.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900))), const SizedBox(height: 8), Text(event.title, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.1, fontWeight: FontWeight.w900)), const SizedBox(height: 8), Text(event.dateLabel, style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.8))])),
          ],
        ),
      );
}
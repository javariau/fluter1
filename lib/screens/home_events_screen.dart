import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key, required this.events, required this.onSelectEvent});

  final List<EventItem> events;
  final ValueChanged<EventItem> onSelectEvent;

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  String _category = 'Semua';

  @override
  Widget build(BuildContext context) {
    final events = _category == 'Semua' ? widget.events : widget.events.where((event) => event.category == _category).toList();
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(color: const Color(0xFF172321), borderRadius: BorderRadius.circular(22)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('GAGASAN BESAR,\nDIMULAI DI SINI.', style: TextStyle(color: Colors.white, fontSize: 28, height: 1.04, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 12),
                        const Text('Ruang temu teknologi, kreativitas, dan orang-orang yang ingin terus bertumbuh.', style: TextStyle(color: Color(0xFFD4DCD7), height: 1.45)),
                        const SizedBox(height: 17),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final date = Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.calendar_month_outlined, color: Color(0xFFCAEF63), size: 19), SizedBox(width: 7), Text('18-21 NOV 2026', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1))]);
                            final badge = Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFCAEF63), borderRadius: BorderRadius.circular(20)), child: const Text('4 HARI • 6 SESI', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10)));
                            return constraints.maxWidth < 220
                              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Icon(Icons.calendar_month_outlined, color: Color(0xFFCAEF63), size: 19), const SizedBox(width: 7), const Expanded(child: Text('18-21 NOV 2026', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1)))]), const SizedBox(height: 8), badge])
                                : Row(children: [date, const Spacer(), badge]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('PROGRAM', style: TextStyle(color: Color(0xFF75807A), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)), SizedBox(height: 3), Text('Seminar & Workshop', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800))])),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final selected = await showCategoryFilter(context, _category);
                          if (selected != null) setState(() => _category = selected);
                        },
                        icon: const Icon(Icons.tune_rounded, size: 17),
                        label: Text(_category == 'Semua' ? 'Filter' : _category),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                sliver: SliverList.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 11),
                    child: EventCard(event: events[index], onTap: () => widget.onSelectEvent(events[index])),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
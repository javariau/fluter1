import 'package:flutter/material.dart';

import 'data/sample_events.dart';
import 'models/event_item.dart';
import 'models/registration_ticket.dart';
import 'screens/event_registration_screen.dart';
import 'screens/gallery_venue_screen.dart';
import 'screens/home_events_screen.dart';
import 'screens/registered_tickets_screen.dart';

void main() => runApp(const NusaEventApp());

class NusaEventApp extends StatefulWidget {
  const NusaEventApp({super.key});

  @override
  State<NusaEventApp> createState() => _NusaEventAppState();
}

class _NusaEventAppState extends State<NusaEventApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final List<RegistrationTicket> _tickets = [];
  int _selectedTab = 0;

  void _openRegistration(EventItem event) {
    _navigatorKey.currentState?.push(
      MaterialPageRoute<void>(
        builder: (context) => EventRegistrationScreen(
          event: event,
          onRegistered: (ticket) {
            setState(() => _tickets.insert(0, ticket));
            _messengerKey.currentState?.hideCurrentSnackBar();
            _messengerKey.currentState?.showSnackBar(
              const SnackBar(content: Text('Pendaftaran berhasil. Tiket aktif sudah tersimpan.')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF172321);
    const paper = Color(0xFFF7F7F1);
    return MaterialApp(
      title: 'NusaEvent Hub',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: _messengerKey,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCAEF63),
          surface: paper,
          primary: ink,
          secondary: const Color(0xFFE56B4B),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: paper,
          foregroundColor: ink,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2E5DC)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: ink, width: 1.5),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 20,
          title: LayoutBuilder(
            builder: (context, constraints) => constraints.maxWidth < 220
                ? const Text('NusaEvent', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, letterSpacing: 0))
                : const Row(
                    children: [
                      Icon(Icons.bubble_chart_rounded, size: 25),
                      SizedBox(width: 8),
                      Text('NusaEvent', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0)),
                      Text(' Hub', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0)),
                    ],
                  ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xFFCAEF63),
                child: Icon(Icons.person_outline_rounded, size: 19, color: ink),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            HomeEventsScreen(events: sampleEvents, onSelectEvent: _openRegistration),
            GalleryVenueScreen(events: sampleEvents),
            RegisteredTicketsScreen(
              tickets: _tickets,
              onCancel: (ticket) => setState(() => _tickets.remove(ticket)),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedTab,
          onDestinationSelected: (index) => setState(() => _selectedTab = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.event_note_outlined), selectedIcon: Icon(Icons.event_note), label: 'Seminar'),
            NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Galeri & peta'),
            NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), selectedIcon: Icon(Icons.confirmation_number), label: 'Tiket'),
          ],
        ),
      ),
    );
  }
}

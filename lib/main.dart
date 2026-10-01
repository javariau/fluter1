import 'package:flutter/material.dart';

const studentName = 'Nama';
const studentId = 'NIM';
const studyProgram = 'Prodi / Kelas';

const _teal = Color(0xFF087E74);
const _orange = Color(0xFFB64D24);

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _teal,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F7F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: _teal,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  bool get _isEven => _count.isEven;
  Color get _countColor => _isEven ? _teal : _orange;

  void _increment() {
    setState(() => _count++);
  }

  void _decrement() {
    if (_count == 0) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Counter tidak boleh kurang dari 0.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    setState(() => _count--);
  }

  void _reset() {
    setState(() => _count = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PPM Sesi 1 - $studentName ($studentId)',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _IdentityCard(
                    name: studentName,
                    id: studentId,
                    studyProgram: studyProgram,
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'COUNTER',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF65736F),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: Text(
                      '$_count',
                      key: ValueKey(_count),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: _countColor,
                            fontSize: 88,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _countColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Text(
                          _isEven ? 'Angka Genap' : 'Angka Ganjil',
                          style: TextStyle(
                            color: _countColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _decrement,
                          icon: const Icon(Icons.remove_rounded),
                          label: const Text('Kurangi'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFE4ECE9),
                            foregroundColor: const Color(0xFF263B36),
                            minimumSize: const Size.fromHeight(52),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _increment,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Tambah'),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _teal,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({
    required this.name,
    required this.id,
    required this.studyProgram,
  });

  final String name;
  final String id;
  final String studyProgram;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFDCE6E2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4F2EE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: _teal,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        id,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF65736F),
                            ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.verified_user_outlined, color: _teal),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.school_rounded, color: _teal, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    studyProgram,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

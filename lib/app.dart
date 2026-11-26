import 'package:flutter/material.dart';

import 'ui/shell/app_shell.dart';

class LandChainApp extends StatelessWidget {
  const LandChainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'LandChain',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF142B4F),
        primary: const Color(0xFF142B4F),
        secondary: const Color(0xFF10B981),
        surface: const Color(0xFFFCFDFD),
      ),
      scaffoldBackgroundColor: const Color(0xFFF4F7F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF4F7F8),
        foregroundColor: Color(0xFF12304A),
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shadowColor: const Color(0x1712304A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE0F1EA),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
    home: const AppShell(),
  );
}

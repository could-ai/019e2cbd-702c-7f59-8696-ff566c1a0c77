import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const UsdAiApp());
}

class UsdAiApp extends StatelessWidget {
  const UsdAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USD.AI Crypto Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00FF7F),
        scaffoldBackgroundColor: const Color(0xFF0A0E17),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FF7F),
          secondary: Color(0xFF00BFFF),
          surface: Color(0xFF151A22),
          background: Color(0xFF0A0E17),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
      },
    );
  }
}

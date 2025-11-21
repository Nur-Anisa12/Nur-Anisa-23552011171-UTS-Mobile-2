import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nur Anisa Profile App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      // 🌞 LIGHT THEME
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[600],
        scaffoldBackgroundColor: Colors.grey[50],

        colorScheme: ColorScheme.light(
          primary: Colors.blue[600]!,
          secondary: Colors.purple[400]!,
          surface: Colors.grey[50]!, // ganti background → surface
        ),

        cardTheme: CardThemeData(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        textTheme: GoogleFonts.poppinsTextTheme(),
        iconTheme: IconThemeData(color: Colors.blue[600]),
      ),

      // 🌙 DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[400],
        scaffoldBackgroundColor: const Color(0xFF121212),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF42A5F5),
          secondary: Color(0xFFCE93D8),
          surface: Color(0xFF121212), // ganti background → surface
        ),

        cardTheme: const CardThemeData(
          elevation: 2,
          color: Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        iconTheme: const IconThemeData(color: Color(0xFF42A5F5)),
      ),

      // HOME PAGE
      home: ProfilPage(
        toggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

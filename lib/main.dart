import 'package:flutter/material.dart';

import 'login_page.dart';
import 'app_strings.dart'; // import untuk multibahasa

// ValueNotifier global agar PengaturanPage bisa mengubah tema dari mana saja
final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

// ValueNotifier global untuk bahasa (default: id - Bahasa Indonesia)
final ValueNotifier<String> languageNotifier = ValueNotifier('id');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder otomatis rebuild MaterialApp saat isDarkModeNotifier berubah
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'Praktikum Login Flutter',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          // Tema terang
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00897B),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF2F4F7),
          ),

          // Tema gelap
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00897B),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF121212),
          ),

          home: LoginPage(), // Memanggil halaman login
        );
      },
    );
  }
}

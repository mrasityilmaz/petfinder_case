import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTheme {
  factory AppTheme() => _instance ??= AppTheme._();

  AppTheme._();
  static AppTheme? _instance;

  final ThemeData _themeData = ThemeData(
    primarySwatch: MaterialColor(const Color(0xFF0055D3).value, const {
      50: Color(0xFFE6F0FF),
      100: Color(0xFFBFD9FF),
      200: Color(0xFF99C2FF),
      300: Color(0xFF73ABFF),
      400: Color(0xFF4C94FF),
      500: Color(0xFF267DFF),
      600: Color(0xFF0066FF),
      700: Color(0xFF0055D3),
      800: Color(0xFF0044A6),
      900: Color(0xFF003379),
    }),
    primaryColor: const Color(0xFF0055D3),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      dragHandleColor: Color(0xffe5e5ea),
    ),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: const Color(0xffe5e5ea),
      hintStyle: GoogleFonts.bricolageGrotesqueTextTheme().labelSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff3C3C43).withOpacity(.6), letterSpacing: .2),
      border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe5e5ea))),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe5e5ea))),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe5e5ea))),
      disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffe5e5ea))),
    ),
    textTheme: GoogleFonts.bricolageGrotesqueTextTheme().copyWith(),
  );

  ThemeData get themeData => _themeData;
}

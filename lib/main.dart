import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/app/portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.dark();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akshay K P | Flutter Developer',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: <PointerDeviceKind>{
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: const Color(0xFF050816),
        colorScheme: baseTheme.colorScheme.copyWith(
          primary: const Color(0xFFA855F7),
          secondary: const Color(0xFF22D3EE),
          surface: const Color(0xFF0B1020),
        ),
        textTheme: GoogleFonts.spaceGroteskTextTheme(baseTheme.textTheme),
      ),
      home: const PortfolioPage(),
    );
  }
}

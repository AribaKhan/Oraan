import 'package:oraan/app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: const Color(0xFF2B4655),
            primaryColorLight: Colors.white,
            accentColor: const Color(0xFF50C4CC),
            primaryColorDark: Color(0xFFD79534),
            scaffoldBackgroundColor: const Color(0xFFF4F6F8),
            textTheme: GoogleFonts.notoSansTextTheme(
              Theme.of(context).textTheme,
            )),
        home: SplashScreen());
  }
}


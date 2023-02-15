import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podcastapp/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const MyHomePage(),
    );
  }
}
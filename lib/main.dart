import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';

void main() => runApp(SwadeshiApp());

class SwadeshiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor:Colors.blue[900],
          textTheme: GoogleFonts.juraTextTheme(Theme.of(context).textTheme)),
      title: 'Swadeshi',
      home: HomePage(),
    );
  }
}

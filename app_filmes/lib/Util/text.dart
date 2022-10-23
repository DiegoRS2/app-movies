import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Modifica_texto extends StatelessWidget {
    final String? text;
    final Color? color;
    final double? size;

  const Modifica_texto({super.key, this.text, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!, style: GoogleFonts.breeSerif(
        color: color, fontSize: size
      ),
    );
  }
}
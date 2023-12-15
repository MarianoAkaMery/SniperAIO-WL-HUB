import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TextToDisplay extends StatelessWidget {
  const TextToDisplay(
      {required this.textToDisplay,
      required this.fontWeight,
      required this.fontsize});

  final String textToDisplay;
  final FontWeight fontWeight;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        textToDisplay,
        style: GoogleFonts.poppins(
          fontWeight: fontWeight,
          fontSize: fontsize,
        ),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }
}

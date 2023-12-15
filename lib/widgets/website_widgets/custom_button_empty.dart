import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomButtonEmpty extends StatelessWidget {
  const CustomButtonEmpty(
      {required this.textToDisplay, required this.functionToexecute});

  final String textToDisplay;
  final void Function() functionToexecute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 18, 18, 18),
          textStyle: const TextStyle(fontSize: 13.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: functionToexecute,
        child: Text(
          textToDisplay,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

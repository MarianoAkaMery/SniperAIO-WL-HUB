import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomButtonFull extends StatelessWidget {
  const CustomButtonFull(
      {required this.textToDisplay, required this.functionToexecute});

  final String textToDisplay;
  final void Function() functionToexecute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 18, 18, 18),
          foregroundColor: Colors.white,
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

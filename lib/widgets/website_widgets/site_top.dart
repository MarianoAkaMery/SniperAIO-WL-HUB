import 'package:flutter/material.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/custom_button_full.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/custom_button_empty.dart';
import 'text_to_display.dart';
import 'package:google_fonts/google_fonts.dart';

class SitoTop extends StatefulWidget {
  const SitoTop(
      {required this.nextScreen,
      required this.backScreen,
      required this.isactiveback,
      required this.isactivenext,
      required this.pageErrorTitle,
      required this.pageErrorDescription});
  final void Function() backScreen;
  final void Function() nextScreen;
  final bool isactiveback;
  final bool isactivenext;
  final String pageErrorTitle;
  final String pageErrorDescription;

  @override
  State<SitoTop> createState() => _SitoTopState();

  ScaffoldFeatureController showError(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final double fontalto = larghezza < 480 ? 12 : 17.5;
    final double fontbasso = larghezza < 480 ? 8 : 12;

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(milliseconds: 1500),
        width: larghezza < 480 ? 300 : 500,
        content: Stack(
          children: [
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 76, 60),
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextToDisplay(
                            //  'Are you sure everything is filled out?',
                            textToDisplay: pageErrorTitle,
                            fontWeight: FontWeight.w800,
                            fontsize: fontalto),
                        Text(
                          pageErrorDescription,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: fontbasso,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      ),
    );
  }
}

class _SitoTopState extends State<SitoTop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: CustomButtonEmpty(
                textToDisplay: 'Back',
                functionToexecute: widget.isactiveback == true
                    ? widget.backScreen
                    : () => widget.showError(context)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: CustomButtonFull(
                textToDisplay: 'Next',
                functionToexecute: widget.isactivenext == true
                    ? widget.nextScreen
                    : () => widget.showError(context)),
          ),
        ),
      ],
    );
  }
}

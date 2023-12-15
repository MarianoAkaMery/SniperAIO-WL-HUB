import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/main.dart' as main;

class LoggedPageSolana extends StatefulWidget {
  const LoggedPageSolana({super.key, required this.checkwallet});
  final Future<void> Function() checkwallet;

  @override
  State<LoggedPageSolana> createState() => LoggedPageSolanaState();
}

class LoggedPageSolanaState extends State<LoggedPageSolana> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.checkwallet();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Show a loading indicator while fetching data
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 350,
                  width: 280,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(50, 88, 88, 88)),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 280,
                            ),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'ADDRESS: \n ${main.user.solanaAddress}',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'SOLANA LOGIN',
                                      textAlign: TextAlign.center,
                                      maxLines: null,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10.5,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

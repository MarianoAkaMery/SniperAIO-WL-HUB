import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/main.dart' as main;

class LoggedPageTw extends StatefulWidget {
  const LoggedPageTw({super.key, required this.checktwitter});
  final Future<void> Function() checktwitter;

  @override
  State<LoggedPageTw> createState() => LoggedPageTwState();
}

class LoggedPageTwState extends State<LoggedPageTw> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.checktwitter();
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(main
                                        .user.twitterprofileBackgroundImage),
                                    fit: BoxFit.cover,
                                    opacity: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      main.user.twitterprofileImage),
                                  maxRadius: 40,
                                  minRadius: 40,
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '@${main.user.twitterprofilename}',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 35.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      main.user.twitterprofileDescription,
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

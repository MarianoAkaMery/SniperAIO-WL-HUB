import 'package:flutter/material.dart';
import '/widgets/website_widgets/text_to_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_signin_button/flutter_signin_button.dart';

typedef OAuthSignIn = void Function();

class UnloggedPageDs extends StatefulWidget {
  const UnloggedPageDs({super.key, required this.signInWithDiscord});
  final Future<void> Function() signInWithDiscord;

  @override
  State<UnloggedPageDs> createState() => UnloggedPageDsState();
}

class UnloggedPageDsState extends State<UnloggedPageDs> {
  String error = '';
  bool isLoading = false;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  _handleMultiFactorException(Future Function() signInWithTwitter) async {
    setIsLoading();
    try {
      await signInWithTwitter();
    } on FirebaseAuthMultiFactorException catch (e) {
      setState(() {
        error = '${e.message}';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = '${e.message}';
      });
    } catch (e) {
      setState(() {
        error = '$e';
      });
    }
    setIsLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                const TextToDisplay(
                    textToDisplay: 'Discord Login',
                    fontWeight: FontWeight.w800,
                    fontsize: 17.5),
                Container(
                  margin: const EdgeInsets.fromLTRB(23, 5, 23, 8),
                  child: const Center(
                    child: TextToDisplay(
                        textToDisplay:
                            'Sign in with Discord to link your account.\nYou can revoke permission at any time.',
                        fontWeight: FontWeight.w300,
                        fontsize: 10.5),
                  ),
                ),
                SafeArea(
                  child: GestureDetector(
                    onTap: FocusScope.of(context).unfocus,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: isLoading
                                    ? Container(
                                        color: Colors.grey[200],
                                        height: 35,
                                        width: 200,
                                      )
                                    : SizedBox(
                                        width: 200,
                                        height: 35,
                                        child: SignInButtonBuilder(
                                          text: 'Sign in with Discord',
                                          icon: Icons.discord,
                                          onPressed: () {
                                            _handleMultiFactorException(
                                              widget.signInWithDiscord,
                                            );
                                          },
                                          backgroundColor: const Color.fromRGBO(
                                              88, 101, 242, 1),
                                        ),
                                      ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

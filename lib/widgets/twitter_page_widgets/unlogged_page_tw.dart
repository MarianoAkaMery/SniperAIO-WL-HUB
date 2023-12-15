import 'package:flutter/material.dart';
import '/widgets/website_widgets/text_to_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sniper_wl_web_app/fonts/my_icons_icons.dart';

typedef OAuthSignIn = void Function();

class UnloggedPageTw extends StatefulWidget {
  const UnloggedPageTw({super.key, required this.signInWithTwitter});
  final Future<void> Function() signInWithTwitter;

  @override
  State<UnloggedPageTw> createState() => UnloggedPageTwState();
}

class UnloggedPageTwState extends State<UnloggedPageTw> {
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

  late Map<Buttons, OAuthSignIn> authButtons = {
    Buttons.Twitter: () => _handleMultiFactorException(
          widget.signInWithTwitter,
        )
  };
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
                    textToDisplay: '𝕏 Login',
                    fontWeight: FontWeight.w800,
                    fontsize: 17.5),
                Container(
                  margin: const EdgeInsets.fromLTRB(23, 5, 23, 8),
                  child: const Center(
                    child: TextToDisplay(
                        textToDisplay:
                            'Sign in with X to link your account.\nYou can revoke permission at any time.',
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
                                          text: '  Sign in with  𝕏 ',
                                          icon: MyIcons.twitter_x,
                                          onPressed: () {
                                            _handleMultiFactorException(
                                              widget.signInWithTwitter,
                                            );
                                          },
                                          backgroundColor: Colors.black,
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

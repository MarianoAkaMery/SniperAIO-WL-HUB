// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:sniper_wl_web_app/widgets/website_widgets/progression_bar_widget.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/site_top.dart';
import 'package:sniper_wl_web_app/main.dart';
import 'package:sniper_wl_web_app/pages/status_page.dart';

import '../main.dart' as main;
import '../utils/function_to_execute.dart';
import '../widgets/discord_page_widgets/logged_page_ds.dart';
import '../widgets/discord_page_widgets/unlogged_page_ds.dart';
import '../widgets/solana_page_widgets/logged_page_web3.dart';
import '../widgets/solana_page_widgets/unlogged_page_web3.dart';
import '../widgets/twitter_page_widgets/logged_page_tw.dart';
import '../widgets/twitter_page_widgets/unlogged_page_tw.dart';

class AuthPage extends StatefulWidget {
  const AuthPage(this.nextScreen, this.backScreen, this.homeScreen,
      {super.key});
  final void Function() nextScreen;
  final void Function() backScreen;
  final void Function() homeScreen;
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String error = '';
  late final UserCredential authResult;
  String? username = '';
  String? profilepic = '';
  String? userId = '';
  String userDescription = '';
  String backgroundImage = '';

  Map<String, dynamic>? meta;

  bool islogged = false;
  bool isLoading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> _signInWithTwitter() async {
    TwitterAuthProvider twitterProvider = TwitterAuthProvider();
    late final FirebaseAuth auth;
    auth = FirebaseAuth.instanceFor(app: app);

    try {
      WidgetsFlutterBinding.ensureInitialized();

      authResult = await auth.signInWithPopup(twitterProvider);
      setState(() {
        username = authResult.user?.displayName;
        meta = authResult.additionalUserInfo?.profile;
        try {
          userDescription = meta?["description"];
          main.user.twitterprofileDescription = userDescription;
        } catch (e) {
          userDescription = '';
          //main.user.profileBackgroundImage = backgroundImage;
          //Non necessario se dichiarato come default
        }
        try {
          backgroundImage = meta?["profile_banner_url"];
          main.user.twitterprofileBackgroundImage = backgroundImage;
        } catch (e) {
          backgroundImage =
              'https://pbs.twimg.com/profile_banners/1196159614921977856/1594140967/1500x500';
          main.user.twitterprofileBackgroundImage = backgroundImage;
        }
        main.user.twitterprofilename = username!;

        try {
          profilepic = meta?["profile_image_url_https"];
          main.user.twitterprofileImage = profilepic!;
        } catch (e) {
          profilepic =
              'https://pbs.twimg.com/profile_images/1588509059296239618/cw7s5y7z_400x400.jpg';
          main.user.twitterprofileImage = profilepic!;
        }

        try {
          userId = meta?["id_str"];
          main.user.twitterId = userId!;
          main.user.istwitterauth = true;
        } catch (e) {
          main.user.istwitterauth = false;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithDiscord() async {
    try {
      // App specific variables
      final discordclient = '1135941052558221312';

      // Construct the url
      Uri url = Uri.https('discord.com', '/oauth2/authorize', {
        'response_type': 'code',
        'client_id': discordclient,
        'redirect_uri': 'http://sniper-39519.web.app/auth.html',
        'scope': 'email identify',
      });

      // Present the dialog to the user
      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: 'index.html');

      // Extract code from resulting url
      final code = Uri.parse(result).queryParameters['code'];
      // Construct an Uri to Google's oauth2 endpoint
      url = Uri.https('discord.com', '/api/oauth2/token');

      // Use this code to get an access token
      final response = await http.post(url, body: {
        'client_id': discordclient,
        'client_secret': 'XuOmNkXp030YXklxnt8Ah7tJmr3LmY1N',
        'redirect_uri': 'http://sniper-39519.web.app/auth.html',
        'grant_type': 'authorization_code',
        'code': code,
      }, headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      });

      // Get the access token from the response
      final accessToken = jsonDecode(response.body)['access_token'] as String;

      url = Uri.https('discord.com', '/api/v9/users/@me');

      final responseauth = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});
      try {
        final discordemail = jsonDecode(responseauth.body)['email'] as String;
        main.user.discordEmail = discordemail;
        final discordname =
            jsonDecode(responseauth.body)['global_name'] as String;
        main.user.discordprofilename = discordname;

        final discordid = jsonDecode(responseauth.body)['id'] as String;
        main.user.discordId = discordid;

        try {
          final discordavatar =
              jsonDecode(responseauth.body)['avatar'] as String;
          main.user.discordprofileImage =
              'https://cdn.discordapp.com/avatars/$discordid/$discordavatar.png';
        } catch (e) {
          main.user.discordprofileImage =
              'https://pbs.twimg.com/profile_images/1588509059296239618/cw7s5y7z_400x400.jpg';
        }

        main.user.isdiscordauth = true;
      } catch (e) {
        main.user.isdiscordauth = false;
      }

      setState(() {
        main.user.isdiscordauth == true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithSolana(String address) async {
    setState(() {
      main.user.solanaAddress = address;
      main.user.issolanaauth = true;

      print('fatto');
    });
  }

  Future<void> checkUserTiwtter() async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var result = await firestoreInstance
          .collection("Users")
          .where("TwitterID", isEqualTo: main.user.twitterId)
          .get();

      if (result.size >= 1) {
        // Iterate through the documents in the QuerySnapshot
        for (var document in result.docs) {
          // Access the "TwitterID" field and print its value
          print("TwitterID: ${document["TwitterID"]}");
          if (main.user.twitterId == document["TwitterID"]) {
            print('We got U sir');
            setState(() {
              main.user.isregistrationdone = true;
              isLoading = false;
            });
          }
        }
      } else {
        print("No matching documents found.");
        setState(() {
          isLoading = false;
          main.user.isregistrationdone = false;
        });
      }
    } catch (e) {
      print("Error while fetching data: $e");
    }

    // Set isLoading to false after completing the query, regardless of the result.
  }

  Future<void> checkUserDiscord() async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var result = await firestoreInstance
          .collection("Users")
          .where("DiscordID", isEqualTo: main.user.discordId)
          .get();

      if (result.size >= 1) {
        // Iterate through the documents in the QuerySnapshot
        for (var document in result.docs) {
          // Access the "TwitterID" field and print its value
          print("DiscordID: ${document["DiscordID"]}");
          if (main.user.discordId == document["DiscordID"]) {
            print('We got U sir');
            setState(() {
              main.user.isregistrationdone = true;
              isLoading = false;
            });
          }
        }
      } else {
        print("No matching documents found.");
        setState(() {
          isLoading = false;
          main.user.isregistrationdone = false;
        });
      }
    } catch (e) {
      print("Error while fetching data: $e");
    }

    // Set isLoading to false after completing the query, regardless of the result.
  }

  Future<void> checkUserWallet() async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var result = await firestoreInstance
          .collection("Users")
          .where("SolanaAddress", isEqualTo: main.user.solanaAddress)
          .get();

      if (result.size >= 1) {
        // Iterate through the documents in the QuerySnapshot
        for (var document in result.docs) {
          // Access the "TwitterID" field and print its value
          print("SolanaAddress: ${document["SolanaAddress"]}");
          if (main.user.solanaAddress == document["SolanaAddress"]) {
            print('We got U sir');
            setState(() {
              main.user.isregistrationdone = true;
              isLoading = false;
            });
          }
        }
      } else {
        print("No matching documents found.");
        setState(() {
          isLoading = false;
          main.user.isregistrationdone = false;
        });
      }
    } catch (e) {
      print("Error while fetching data: $e");
    }

    // Set isLoading to false after completing the query, regardless of the result.
  }

  @override
  Widget build(BuildContext context) {
    final l = 400.0;

    return main.user.isregistrationdone == true
        ? StatusPage(widget.homeScreen)
        : SingleChildScrollView(
            child: Column(
              children: [
                SitoTop(
                  nextScreen: widget.nextScreen,
                  backScreen: widget.backScreen,
                  isactiveback: true,
                  isactivenext: true,
                  pageErrorTitle: 'Are you sure everything is filled out?',
                  pageErrorDescription: 'Make sure to finish Login',
                ),
                ProgressionBarSniper(indexToDisplay: 0),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: l,
                    maxHeight: l,
                  ),
                  child: IntrinsicHeight(
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return index == 0
                            ? main.user.istwitterauth == true
                                ? LoggedPageTw(
                                    checktwitter: checkUserTiwtter,
                                  )
                                : UnloggedPageTw(
                                    signInWithTwitter: _signInWithTwitter,
                                  )
                            : index == 1
                                ? main.user.isdiscordauth == true
                                    ? LoggedPageDs(
                                        checkdiscord: checkUserDiscord,
                                      )
                                    : UnloggedPageDs(
                                        signInWithDiscord: _signInWithDiscord,
                                      )
                                : index == 2
                                    ? main.user.issolanaauth == true
                                        ? LoggedPageSolana(
                                            checkwallet: checkUserWallet,
                                          )
                                        : UnloggedPageSolana(
                                            signInWithSolana: _signInWithSolana,
                                          )
                                    : (main.user.istwitterauth == true &&
                                            main.user.isdiscordauth == true)
                                        ? // && main.user.issolanaauth
                                        const Text('data')
                                        : FunctionExecutingWidget(
                                            functionToExecute: () {},
                                          );
                      },
                      itemCount: 3,
                      pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.black,
                              activeColor: Color.fromARGB(121, 88, 225, 175)),
                          margin: EdgeInsets.all(0)),
                      control: const SwiperControl(
                          color: Colors.black, padding: EdgeInsets.all(8)),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

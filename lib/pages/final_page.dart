import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/main.dart' as main;
import '../widgets/website_widgets/custom_button_full.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/site_footer.dart';

import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => FinalPageState();
}

class FinalPageState extends State<FinalPage> {
  bool isLoading = true;
  bool found = false;

  @override
  void initState() {
    super.initState();

    sendtodbok();
  }

  void _launchTwitterWithPreMadeTweet() async {
    // Construct the Twitter URL with the premade tweet
    String preMadeTweet = "Check out this awesome app! #Flutter";
    Uri twitterUrl =
        Uri.https('twitter.com', 'compose/tweet', {'text': preMadeTweet});

    // Check if the URL can be launched
    if (await canLaunchUrl(twitterUrl)) {
      await launchUrl(twitterUrl); // Open the URL in the browser
    } else {
      throw 'Could not launch $twitterUrl';
    }
  }

  Future<void> sendtodbok() async {
    if (main.user.isregistrationdone == true) {
      print('ci sei');
      setState(() {
        isLoading = false;
      });
    } else {
      print('Mando al Db');

      final firestoreInstance = FirebaseFirestore.instance;

      try {
        firestoreInstance.collection("Users").add({
          "TwitterName": main.user.twitterprofilename,
          "TwitterProfileImage": main.user.twitterprofileImage,
          "TwitterDescription": main.user.twitterprofileDescription,
          "TwitterBannerImage": main.user.twitterprofileBackgroundImage,
          "TwitterID": main.user.twitterId,
          "DiscordProfileName": main.user.discordprofilename,
          "DiscordProfileImage": main.user.discordprofileImage,
          "DiscordID": main.user.discordId,
          "DiscordEmail": main.user.discordEmail,
          "SolanaAddress": main.user.solanaAddress,
          "CategoryIndex": main.user.categoryIndex,
          "Category": main.user.profileCategory,
          "QuestionsReply": main.user.usersavedreply,
        }).then((value) {
          print(value.id);
        });
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
      }

      // Set isLoading to false after completing the query, regardless of the result.
    }
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;
    // ignore: unrelated_type_equality_checks
    return isLoading
        ? const Center(
            child:
                CircularProgressIndicator(), // Show a loading indicator while fetching data
          )
        : Scaffold(
            body: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(
                                    'lib/assets/variant-transparent.png',
                                    height: 60,
                                  ),
                                ),
                              ),
                              if (altezza < larghezza)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        'lib/assets/sniper.png',
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        main.user.discordprofileImage),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomButtonFull(
                                  textToDisplay: 'Share on 𝕏',
                                  functionToexecute:
                                      _launchTwitterWithPreMadeTweet,
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.focused)) {
                                          return Colors.red;
                                        }
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          return const Color.fromARGB(
                                              32, 76, 175, 173);
                                        }
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors.blue;
                                        }
                                        return null; // Defer to the widget's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    Restart.restartApp();
                                  },
                                  child: const Text(
                                    'Restart Application',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(
                                  height: 68,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            persistentFooterAlignment: AlignmentDirectional.bottomCenter,
            persistentFooterButtons: const [
              SitoFooter(),
            ],
          );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/site_footer.dart';
import '/main.dart' as main;
import 'package:solana_wallet_provider/solana_wallet_provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sniper_wl_web_app/fonts/my_icons_icons.dart';

import '../widgets/website_widgets/custom_button_empty.dart';

class StatusPage extends StatefulWidget {
  const StatusPage(
    this.homeScreen,
  );
  final void Function() homeScreen;

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool resultwallet = false;

  @override
  void initState() {
    super.initState();
    checkwallet();
  }

  Future<void> checkwallet() async {
    WidgetsFlutterBinding.ensureInitialized();

    final firestoreInstance = FirebaseFirestore.instance;
    try {
      final provider = SolanaWalletProvider.of(context);

      if (provider.adapter.isAuthorized == true) {
        final jsonResult = provider.adapter.connectedAccount?.toJson();
        String address = jsonResult?['address'];
        main.user.solanaAddress = address;

        var result = await firestoreInstance
            .collection("Users")
            .where("SolanaAddress", isEqualTo: main.user.solanaAddress)
            .get();

        if (result.size >= 1) {
          print(result.size);

          // Iterate through the documents in the QuerySnapshot
          for (var document in result.docs) {
            // Access the "TwitterID" field and print its value
            print("SolanaAddress: ${document["SolanaAddress"]}");
            if (main.user.solanaAddress == document["SolanaAddress"]) {
              print('We got U sir');
              setState(() {
                resultwallet = true;
                main.user.isregistrationdone = true;
              });
              break;
            }
          }
        } else {
          print("No matching documents found.");
          setState(() {
            resultwallet = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        resultwallet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;

    return Scaffold(
      body: larghezza < 480
          ? Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return const Color.fromARGB(
                                          82, 92, 91, 91);
                                    }
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return const Color.fromARGB(
                                          169, 78, 77, 77);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              child: const Text(
                                'About Us',
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      CustomButtonEmpty(
                          textToDisplay: 'Check Status',
                          functionToexecute: () {})
                    ]),
                const SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: altezza / 2 - 50,
                        width: larghezza / 1.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: resultwallet
                            ? Column(children: [])
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder(
                                    // 2. Initialize SolanaWalletProvider before use.
                                    future: SolanaWalletProvider.initialize(),
                                    builder: ((context, snapshot) {
                                      if (snapshot.connectionState !=
                                          ConnectionState.done) {
                                        return const CircularProgressIndicator();
                                      }
                                      // 3. Access SolanaWalletProvider.

                                      final provider =
                                          SolanaWalletProvider.of(context);

                                      return SignInButtonBuilder(
                                        text: 'Select Wallet',
                                        icon: MyIcons.solana_sol_logo,
                                        onPressed: () async {
                                          try {
                                            WidgetsFlutterBinding
                                                .ensureInitialized();

                                            await provider
                                                .connect(context,
                                                    dismissState:
                                                        DismissState.success)
                                                .then(
                                                  (result) => (setState(() {
                                                    final jsonResult = provider
                                                        .adapter
                                                        .connectedAccount
                                                        ?.toJson();
                                                    print(jsonResult);
                                                    String address =
                                                        jsonResult?['address'];
                                                    main.user.solanaAddress =
                                                        address;

                                                    main.user.issolanaauth =
                                                        true;
                                                    print('fatto');
                                                  })),
                                                );
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        backgroundColor: const Color.fromRGBO(
                                            226, 223, 254, 1),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color.fromARGB(12, 18, 18, 15);
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color.fromARGB(12, 18, 18, 15);
                                }
                                return null;
                              },
                            ),
                          ),
                          onPressed: widget.homeScreen,
                          child: const Text(
                            'Back Home',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Row(
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return const Color.fromARGB(
                                          12, 18, 18, 15);
                                    }
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return const Color.fromARGB(
                                          12, 18, 18, 15);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'About Us',
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return const Color.fromARGB(
                                          12, 18, 18, 15);
                                    }
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return const Color.fromARGB(
                                          12, 18, 18, 15);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Work with Us',
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      ),
                    ]),
                const SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: altezza / 2 - 50,
                        width: larghezza / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: resultwallet
                            ? Column(children: [])
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder(
                                    // 2. Initialize SolanaWalletProvider before use.
                                    future: SolanaWalletProvider.initialize(),
                                    builder: ((context, snapshot) {
                                      if (snapshot.connectionState !=
                                          ConnectionState.done) {
                                        return const CircularProgressIndicator();
                                      }
                                      // 3. Access SolanaWalletProvider.

                                      final provider =
                                          SolanaWalletProvider.of(context);

                                      return SignInButtonBuilder(
                                        text: 'Select Wallet',
                                        icon: MyIcons.solana_sol_logo,
                                        onPressed: () async {
                                          try {
                                            WidgetsFlutterBinding
                                                .ensureInitialized();

                                            await provider
                                                .connect(context,
                                                    dismissState:
                                                        DismissState.success)
                                                .then(
                                                  (result) => (setState(() {
                                                    final jsonResult = provider
                                                        .adapter
                                                        .connectedAccount
                                                        ?.toJson();
                                                    print(jsonResult);
                                                    String address =
                                                        jsonResult?['address'];
                                                    main.user.solanaAddress =
                                                        address;

                                                    main.user.issolanaauth =
                                                        true;
                                                    print('fatto');
                                                  })),
                                                );
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        backgroundColor: const Color.fromRGBO(
                                            226, 223, 254, 1),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color.fromARGB(12, 18, 18, 15);
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color.fromARGB(12, 18, 18, 15);
                                }
                                return null;
                              },
                            ),
                          ),
                          onPressed: widget.homeScreen,
                          child: const Text(
                            'Back Home',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                )
              ],
            ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: const [
        SitoFooter(),
      ],
    );
  }
}

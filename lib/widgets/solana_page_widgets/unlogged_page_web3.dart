import 'package:flutter/material.dart';
import 'package:sniper_wl_web_app/fonts/my_icons_icons.dart';
import '/widgets/website_widgets/text_to_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:solana_wallet_provider/solana_wallet_provider.dart';

typedef OAuthSignIn = void Function();

class UnloggedPageSolana extends StatefulWidget {
  const UnloggedPageSolana({super.key, required this.signInWithSolana});
  final Function(String) signInWithSolana;

  @override
  State<UnloggedPageSolana> createState() => UnloggedPageSolanaState();
}

class UnloggedPageSolanaState extends State<UnloggedPageSolana> {
  bool isLoading = false;
  late final Future<void> _future;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final adapter = SolanaWalletAdapter(
      AppIdentity(
        name: 'SniperAIO WL-HUB',
        uri: Uri.parse('https://sniper-39519.web.app'),
        icon: Uri.parse(
            'https://media.discordapp.net/attachments/933679396932444170/933679491077767208/Logo-real-3d-effect.jpg?ex=65841cc9&is=6571a7c9&hm=ec2cbc1qk55vk7wjgzg3pmxlh59rv5dlgewd9jem5nrt4wcebe3ca6b838aed2c365&=&format=webp&width=675&height=675'),
      ),
      // NOTE: CONNECT THE WALLET APPLICATION
      //       TO THE SAME NETWORK.
      cluster: Cluster.mainnet,
      hostAuthority: null,
    );
    Map<String, dynamic> _output;

    @override
    void initState() {
      super.initState();
      _future = SolanaWalletAdapter.initialize();
    }

    Future<void> _connect() async {
      setState(() {});
      if (!adapter.isAuthorized) {
        await adapter.authorize(
            walletUriBase: adapter.store.apps[0].walletUriBase);
        setState(() {});
      }
    }

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
                    textToDisplay: 'Solana Verification',
                    fontWeight: FontWeight.w800,
                    fontsize: 17.5),
                Container(
                  margin: const EdgeInsets.fromLTRB(23, 5, 23, 8),
                  child: const TextToDisplay(
                    textToDisplay:
                        'Connect your Phantom Wallet.\nYou can revoke permission at any time.',
                    fontWeight: FontWeight.w300,
                    fontsize: 10.5,
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
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: isLoading
                                      ? Container(
                                          color: Colors.grey[200],
                                          height: 35,
                                          width: 200,
                                        )
                                      : larghezza > 480
                                          ? SizedBox(
                                              width: 200,
                                              height: 35,
                                              child: FutureBuilder(
                                                // 2. Initialize SolanaWalletProvider before use.
                                                future: SolanaWalletProvider
                                                    .initialize(),
                                                builder: ((context, snapshot) {
                                                  if (snapshot
                                                          .connectionState !=
                                                      ConnectionState.done) {
                                                    return const CircularProgressIndicator();
                                                  }
                                                  // 3. Access SolanaWalletProvider.

                                                  final provider =
                                                      SolanaWalletProvider.of(
                                                          context);

                                                  return SignInButtonBuilder(
                                                    text:
                                                        '   Select Wallet Dekstop',
                                                    icon:
                                                        MyIcons.solana_sol_logo,
                                                    onPressed: () async {
                                                      try {
                                                        WidgetsFlutterBinding
                                                            .ensureInitialized();

                                                        await provider
                                                            .connect(context,
                                                                dismissState:
                                                                    DismissState
                                                                        .success)
                                                            .then(
                                                              (result) =>
                                                                  (setState(
                                                                () {
                                                                  final jsonResult = provider
                                                                      .adapter
                                                                      .connectedAccount
                                                                      ?.toJson();
                                                                  print(
                                                                      jsonResult);
                                                                  String
                                                                      address =
                                                                      jsonResult?[
                                                                          'address'];
                                                                  isLoading =
                                                                      false;

                                                                  widget.signInWithSolana(
                                                                      address);
                                                                },
                                                              )),
                                                            );
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    },
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            226, 223, 254, 1),
                                                  );
                                                }),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 200,
                                              height: 35,
                                              child: TextButton(
                                                onPressed: () {
                                                  _connect();
                                                },
                                                child:
                                                    const Text('Authorize v2'),
                                              ),
                                            ),
                                )),
                          ],
                        ),
                      ),
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

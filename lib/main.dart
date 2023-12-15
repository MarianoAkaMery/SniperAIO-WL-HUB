import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widgets/logic_widgets/change_page.dart';
import './utils/user_profile.dart';
import 'utils/firebase_options.dart';
import 'package:solana_wallet_provider/solana_wallet_provider.dart';

late final FirebaseApp app;
//flutter run -d chrome --web-port 8080
//flutter build web --web-renderer html --no-tree-shake-icons
bool shouldUseFirebaseEmulator = false;
UserProfile user = UserProfile(
  istwitterauth: false,
  isdiscordauth: false,
  issolanaauth: false,
  iscategorydecided: false,
  twitterprofilename: '',
  twitterprofileDescription: '',
  twitterprofileBackgroundImage: '',
  twitterprofileImage: '',
  profileCategory: '',
  discordEmail: '',
  discordId: '',
  discordprofileImage: '',
  discordprofilename: '',
  categoryIndex: 56,
  usersavedreply: const {},
  twitterId: '',
  isregistrationdone: false,
  solanaAddress: '',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(app);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // 2. Initialize SolanaWalletProvider before use.
      future: SolanaWalletProvider.initialize(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }
        // 3. Access SolanaWalletProvider.

        return SolanaWalletProvider.create(
            identity: AppIdentity(
                uri: Uri.parse('http://localhost:8080/'),
                icon: Uri.parse(
                    'https://media.discordapp.net/attachments/933679396932444170/933679491077767208/Logo-real-3d-effect.jpg?width=676&height=676'),
                name: 'SniperAIO WL - HUB'),
            child: CambiaPagina(
              indexFromPage: 0,
            ));
      }),
    );
  }
}

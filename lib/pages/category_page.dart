import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/categorygrid.dart';
import '../widgets/website_widgets/site_top.dart';
import 'package:sniper_wl_web_app/main.dart' as main;
import '../widgets/website_widgets/progression_bar_widget.dart';

const lavori = [
  'Founder',
  'Community Manager',
  'Influencer',
  'Alpha Caller',
  'Trader',
  'Mod',
  'Content creator',
  'Other'
];

const bio = [
  'Innovators who lead the way, shaping our project\'s future',
  'Engagement experts who breathe life into community',
  'Social media superstars spreading the NFT buzz',
  'Trailblazing enthusiasts driving project momentum',
  'Market mavens shaping NFT trading trends',
  'Guardians of our community\'s positive vibes.',
  'Storytellers who turn NFTs into art',
  'Other'
];

class CategoryPage extends StatefulWidget {
  const CategoryPage(this.nextScreen, this.backScreen);
  final void Function() nextScreen;
  final void Function() backScreen;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Future<void> _choosecategory(int index) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      setState(() {
        main.user.iscategorydecided = true;
        main.user.profileCategory = lavori[index];
        main.user.categoryIndex = index;
        widget.nextScreen();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;

    int n = 0;

    larghezza < 480 ? n = 2 : n = 3;
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: SitoTop(
            nextScreen: widget.nextScreen,
            backScreen: widget.backScreen,
            isactiveback: true,
            isactivenext: main.user.iscategorydecided,
            pageErrorTitle: 'You have to select a category',
            pageErrorDescription: 'It’s not hard, bozo',
          ),
        ),
        larghezza < 480
            ? Column(
                children: [
                  ProgressionBarSniper(indexToDisplay: 1),
                  Container(
                    height: 25,
                    child: Text(
                      'Choose the category that fits you',
                      style: GoogleFonts.orelegaOne(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Text(
                      'Who are you?',
                      style: GoogleFonts.lato(
                        fontSize: 10,
                        color: const Color.fromARGB(255, 92, 91, 91),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  ProgressionBarSniper(indexToDisplay: 1),
                  Container(
                    height: 50,
                    child: Text(
                      'Choose the category that fits you',
                      style: GoogleFonts.orelegaOne(fontSize: 30),
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Text(
                      'Who are you?',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 92, 91, 91),
                      ),
                    ),
                  ),
                ],
              ),
        Container(
            child: larghezza > 480
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: MyGrid(
                      choosecategory: _choosecategory,
                      n: n,
                    ))
                : MyGrid(
                    choosecategory: _choosecategory,
                    n: n,
                  )),
      ],
    ));
  }
}

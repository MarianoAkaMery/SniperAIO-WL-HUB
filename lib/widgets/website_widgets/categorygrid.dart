import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sniper_wl_web_app/main.dart' as main;

class MyGrid extends StatelessWidget {
  MyGrid({required this.n, required this.choosecategory});
  final Function(int) choosecategory;
  final int n;
  final lavori = [
    'Founder',
    'Community Manager',
    'Influencer',
    'Educator',
    'Alpha Caller',
    'Trader',
    'Mod',
    'Content creator',
    'Other'
  ];

  final bio = [
    'Innovators who lead the way, shaping our project\'s future',
    'Engagement experts who breathe life into community',
    'Social media superstars spreading the NFT buzz',
    'NFT gurus who simplify the complex',
    'Trailblazing enthusiasts driving project momentum',
    'Market mavens shaping NFT trading trends',
    'Guardians of our community\'s positive vibes.',
    'Storytellers who turn NFTs into art',
    'other thing that aren\'t in this list'
  ];

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    double sizefont1 = larghezza < 480 ? 13 : 18;
    double sizefont2 = larghezza < 480 ? 9 : 12;
    double altmax = larghezza < 480 ? 500 : 400;
    return Container(
        constraints: BoxConstraints(
          minHeight: 200,
          maxHeight: altmax,
          maxWidth: 700,
        ),
        child: GridView.count(
          crossAxisCount: n,
          childAspectRatio: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          padding: EdgeInsets.all(10.0),
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            ...lavori.asMap().entries.map(
              (entry) {
                final item = entry.value;
                final index = entry.key;
                final bioText = bio[index];

                return Container(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: index == main.user.categoryIndex
                          ? MaterialStateProperty.all<Color>(
                              Color.fromARGB(121, 88, 225, 175))
                          : MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Color.fromARGB(121, 88, 225, 175);
                          if (states.contains(MaterialState.pressed))
                            return Color.fromARGB(121, 88, 225, 175);
                          return null;
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => {choosecategory(index)},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.orelegaOne(
                              color: Colors.black,
                              fontSize: sizefont1,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            bioText,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                                color: const Color.fromARGB(255, 92, 91, 91),
                                fontSize: sizefont2,
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.clip,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}

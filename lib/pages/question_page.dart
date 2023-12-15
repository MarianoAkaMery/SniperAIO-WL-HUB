import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sniper_wl_web_app/widgets/website_widgets/progression_bar_widget.dart';
import '../widgets/website_widgets/site_top.dart';
import '../widgets/website_widgets/custom_button_full.dart';
import 'package:sniper_wl_web_app/main.dart' as main;

Map<int, List<String>> questionsMap = {
  0: [
    "What aspects of the NFT and blockchain space do you actively engage with in your daily life? How do you contribute to the community and feel part of it?",
    "Please describe your experience in founding or leading blockchain or NFT-related projects. Highlight any relevant achievements or successful launches.",
    "How do you envision your role as a founder within our specific NFT project? What unique contributions do you plan to make to this project's success?",
  ],
  1: [
    "How do you engage with NFT and blockchain communities currently? Share your experiences in fostering community engagement.",
    "Describe your community management experience, especially within the NFT or blockchain space. Highlight any successful strategies or initiatives.",
    "How do you plan to foster engagement and growth within our NFT project's community? What unique ideas or approaches do you bring?",
  ],
  2: [
    "Please list your current follower count and engagement metrics on your primary social media platforms within the NFT and blockchain space.",
    "How do you use your influence to promote and support NFT and blockchain projects? Share any collaborations or partnerships.",
    "How do you plan to use your influence to promote our specific NFT project? What strategies do you have in mind to reach and engage your audience?",
  ],
  3: [
    "How did you become interested in NFTs and blockchain technology? Describe your journey as an early adopter or enthusiast.",
    "What notable experiences or successes have you had within the NFT market or NFT communities?",
    "Why are you interested in our specific NFT project? How do you see yourself contributing to its success as an early adopter?",
  ],
  4: [
    "Share examples of your content creation work related to NFTs or blockchain technology. How do you engage with content consumers in the space?",
    "What type of content (e.g., articles, videos, art) do you specialize in, and what successes have you achieved?",
    "How do you plan to use your content creation skills to support our specific NFT project? What kind of content do you intend to produce for this project?",
  ],
  5: [
    "Describe your experience as a moderator in NFT or blockchain-related communities and your role in maintaining positive environments.",
    "Share examples of challenging moderation situations you've encountered and how you handled them.",
    "How do you plan to ensure a positive and safe community environment within our specific NFT project? What approaches will you take as a moderator?",
  ],
  6: [
    "What is your trading strategy within the NFT space, and how do you stay connected with NFT communities?",
    "Share your experiences and successes as an NFT trader, if any. Highlight any notable trades or market insights.",
    "How do you plan to contribute to the trading and liquidity aspects of our specific NFT project? What strategies do you have in mind?",
  ],
  7: [
    "What is your trading strategy within the NFT space, and how do you stay connected with NFT communities?",
    "Share your experiences and successes as an NFT trader, if any. Highlight any notable trades or market insights.",
    "How do you plan to contribute to the trading and liquidity aspects of our specific NFT project? What strategies do you have in mind?",
  ],
};

Map<String, String> userReply = {};
int _index = 0;

class QuestionPage extends StatefulWidget {
  final void Function() nextScreen;
  final void Function() backScreen;
  const QuestionPage(this.nextScreen, this.backScreen);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<String>? questions = questionsMap[main.user.categoryIndex];
  bool doneRegister = false;
  int questionLength = questionsMap[main.user.categoryIndex]!.length;

  List<String?> savedreply =
      List<String?>.filled(questionsMap[main.user.categoryIndex]!.length, null);

  void submit(index, length, writedtext) {
    setState(() {
      if (_index < length) {
        savedreply[index] = writedtext;
        userReply[questions![_index]] = writedtext;
        _index += 1;
      }
    });
  }

  void back() {
    setState(() {
      _index -= 1;
    });
  }

  Future<void> setlast(index, writedtext) async {
    savedreply[index] = writedtext;
    userReply[questions![_index]] = writedtext;
    main.user.usersavedreply = userReply;
    widget.nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;
    final altezza = MediaQuery.of(context).size.height;
    TextEditingController titleController =
        TextEditingController(text: savedreply[_index]);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: SitoTop(
              backScreen: widget.backScreen,
              nextScreen: widget.nextScreen,
              isactiveback: true,
              isactivenext: false,
              pageErrorTitle: 'Are you sure everything is filled out?',
              pageErrorDescription: 'Make sure to reply to the question',
            ),
          ),
          larghezza < 480
              ? Column(
                  children: [
                    ProgressionBarSniper(indexToDisplay: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SafeArea(
                        child: Text(
                          questions![_index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.orelegaOne(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'by repling to this question you wil bla bla...',
                      style: GoogleFonts.lato(
                        fontSize: 10,
                        color: const Color.fromARGB(255, 92, 91, 91),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    ProgressionBarSniper(indexToDisplay: 2),
                    Container(
                      width: 700,
                      child: Text(
                        questions![_index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orelegaOne(fontSize: 20),
                      ),
                    ),
                    Text(
                      'by repling to this question you wil bla bla...',
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 92, 91, 91),
                      ),
                    ),
                  ],
                ),
          Container(
            height: 20,
          ),
          larghezza < 480
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: altezza / 2 - 50,
                    width: larghezza - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          maxLines:
                              null, // Imposta il numero di righe a null per consentire qualsiasi numero di righe.
                          keyboardType: TextInputType
                              .multiline, // Abilita l'input di testo multilinea.
                          textInputAction: TextInputAction.newline,
                          controller: titleController,
                          cursorColor: Colors.black54,
                          maxLength: 300,

                          //colore del cursore
                          decoration: const InputDecoration(
                              label: Text(
                                'Write here..',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black54),
                              fillColor: Colors.black54,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                                //  when the TextFormField in unfocused
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                //  when the TextFormField in focused
                              ),
                              border: UnderlineInputBorder()),
                          autofocus: true),
                    ),
                  ),
                )
              : Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        maxLines:
                            null, // Imposta il numero di righe a null per consentire qualsiasi numero di righe.
                        keyboardType: TextInputType
                            .multiline, // Abilita l'input di testo multilinea.
                        textInputAction: TextInputAction.newline,
                        controller: titleController,
                        cursorColor: Colors.black54,
                        maxLength: 300,

                        //colore del cursore
                        decoration: const InputDecoration(
                            label: Text(
                              'Write here..',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            hintStyle: TextStyle(color: Colors.black54),
                            fillColor: Colors.black54,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              //  when the TextFormField in focused
                            ),
                            border: UnderlineInputBorder()),
                        autofocus: true),
                  ),
                ),
          Container(
            width: 500,
            alignment: Alignment.bottomRight,
            child: _index == 0
                ? Container(
                    child: CustomButtonFull(
                    textToDisplay: 'Next',
                    functionToexecute: () =>
                        {submit(_index, questionLength, titleController.text)},
                  ))
                : Container(
                    child: Row(
                      children: [
                        CustomButtonFull(
                          textToDisplay: 'Back',
                          functionToexecute: () => {back()},
                        ),
                        const Spacer(),
                        CustomButtonFull(
                          textToDisplay:
                              _index == questionLength - 1 ? 'Submit' : 'Next',
                          functionToexecute: () => {
                            _index == questionLength - 1
                                ? setlast(_index, titleController.text)
                                : submit(_index, questionLength,
                                    titleController.text)
                          },
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/website_widgets/custom_button_full.dart';
import '../widgets/website_widgets/custom_button_empty.dart';
import '../widgets/website_widgets/site_footer.dart';

class MainPage extends StatefulWidget {
  const MainPage(
      this.nextScreen, this.backScreen, this.statusScreen, this.homeScreen);
  final void Function() nextScreen;
  final void Function() backScreen;
  final void Function() statusScreen;
  final void Function() homeScreen;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final larghezza = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: larghezza < 480
                  ? Column(children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.hovered)) {
                                            return const Color.fromARGB(
                                                82, 92, 91, 91);
                                          }
                                          if (states.contains(
                                              MaterialState.pressed)) {
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
                                functionToexecute: widget.statusScreen)
                          ]),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'lib/assets/sniper.png',
                                  height: 150,
                                  width: 150,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomButtonFull(
                              textToDisplay: 'Apply Now',
                              functionToexecute: widget.nextScreen,
                            ),
                          ],
                        ),
                      ),
                    ])
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
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return const Color.fromARGB(
                                                  12, 18, 18, 15);
                                            }
                                            if (states.contains(
                                                MaterialState.pressed)) {
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
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return const Color.fromARGB(
                                                  12, 18, 18, 15);
                                            }
                                            if (states.contains(
                                                MaterialState.pressed)) {
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
                              CustomButtonEmpty(
                                  textToDisplay: 'Check Status',
                                  functionToexecute: widget.statusScreen)
                            ]),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'lib/assets/sniper.png',
                                    height: 150,
                                    width: 150,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomButtonFull(
                                textToDisplay: 'Apply Now',
                                functionToexecute: widget.nextScreen,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      }),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: const [
        SitoFooter(),
      ],
    );
  }
}

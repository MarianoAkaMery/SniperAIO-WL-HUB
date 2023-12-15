import 'package:flutter/material.dart';
import 'package:sniper_wl_web_app/fonts/my_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SitoFooter extends StatefulWidget {
  const SitoFooter();

  @override
  State<SitoFooter> createState() => _SitoFooterState();
}

class _SitoFooterState extends State<SitoFooter> {
  void _launchTwitter() async {
    Uri twitterlink = Uri.https('twitter.com', 'sniper_AIO');

    // Check if the URL can be launched
    if (await canLaunchUrl(twitterlink)) {
      await launchUrl(twitterlink); // Open the URL in the browser
    } else {
      throw 'Could not launch $twitterlink';
    }
  }

  void _launchDiscord() async {
    Uri discordlink = Uri.https('discord.gg', 'sniperaio');

    // Check if the URL can be launched
    if (await canLaunchUrl(discordlink)) {
      await launchUrl(discordlink); // Open the URL in the browser
    } else {
      throw 'Could not launch $discordlink';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            GestureDetector(
              child: Text(
                'Tos',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              onTap: () {
                print('tos');
              },
            ),
            GestureDetector(
              child: Text(
                'Privacy',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              onTap: () {
                print('privacuy');
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'SniperAIO\n Expand your business with our technology',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: _launchTwitter,
                    icon: const Icon(
                      MyIcons.twitter_x,
                      size: 18,
                    )),
                IconButton(
                    onPressed: _launchDiscord,
                    icon: const Icon(
                      Icons.discord,
                      size: 18,
                    )),
              ],
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              child: Text(
                'About us',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              onTap: () {},
            ),
            GestureDetector(
              child: Text(
                'Other',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'TOS',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10, color: Colors.black),
    );
  }
}

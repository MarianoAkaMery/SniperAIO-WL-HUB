import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  UserProfile({
    super.key,
    required this.twitterprofilename,
    required this.twitterprofileImage,
    required this.istwitterauth,
    required this.isdiscordauth,
    required this.issolanaauth,
    required this.iscategorydecided,
    required this.profileCategory,
    required this.categoryIndex,
    required this.twitterprofileDescription,
    required this.twitterprofileBackgroundImage,
    required this.usersavedreply,
    required this.twitterId,
    required this.isregistrationdone,
    required this.discordprofilename,
    required this.discordprofileImage,
    required this.discordId,
    required this.discordEmail,
    required this.solanaAddress,
  });

  //twitter
  late String twitterprofilename;
  late String twitterprofileImage;
  late String twitterId;
  late String twitterprofileDescription;
  late String twitterprofileBackgroundImage;
  //Discord
  late String discordprofilename;
  late String discordprofileImage;
  late String discordId;
  late String discordEmail;
  //web3
  late String solanaAddress;
  //application
  late Map<String, String> usersavedreply;
  late String profileCategory;
  late int categoryIndex;

  bool istwitterauth = false;
  bool isdiscordauth = false;
  bool issolanaauth = false;

  bool iscategorydecided = false;
  bool isregistrationdone = false;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String getName() {
    return widget.twitterprofilename;
  }

  String getImage() {
    return widget.twitterprofileBackgroundImage;
  }

  bool getTwitterStatus() {
    return widget.istwitterauth;
  }

  bool getCategoryStatus() {
    return widget.iscategorydecided;
  }

  void setName(String name) {
    widget.twitterprofilename = name;
  }

  void setProfilePic(String profilepic) {
    widget.twitterprofileImage = profilepic;
  }

  void setTwitterauth() {
    setState(() {
      widget.istwitterauth = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

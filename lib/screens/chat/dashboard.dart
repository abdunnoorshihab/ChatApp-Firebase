import '../../../const_config/color_config.dart';
import '../../../screens/auth/sign_up.dart';
import '../../../screens/chat/chat_tabs/chats.dart';
import '../../../screens/chat/chat_tabs/discover.dart';
import '../../../screens/chat/chat_tabs/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../const_config/text_config.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 1;
  final pageViewController = PageController(initialPage: 1);

  // @override
  // void initState() {
  //
  //
  //   /// This function runs after the widget is build....
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //
  //     pageViewController.jumpToPage(1);
  //   });
  //   super.initState();
  // }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 65),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome to",
                        style: TextDesign().dashboardWidgetTitle),
                    Text("Chat META",
                        style: TextDesign()
                            .popHead
                            .copyWith(color: MyColor.primary, fontSize: 22)),
                  ],
                ),
                if (selectedIndex == 2)
                  IconButton(
                      onPressed: () {
                        final auth = FirebaseAuth.instance;
                        auth.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                            (route) => false);
                      },
                      icon: const Icon(Icons.logout))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: PageView(
                controller: pageViewController,
                onPageChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                children: const [
                  DiscoverPage(),
                  ChatsPage(),
                  ProfilePage(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: FlashyTabBar(
          selectedIndex: selectedIndex,
          showElevation: true,
          backgroundColor: MyColor.white,
          onItemSelected: (index) {
            setState(() {
              if ((selectedIndex - index).abs() > 1) {
                pageViewController.jumpToPage(index);
              }
              pageViewController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
              selectedIndex = index;
            });
          },
          items: [
            FlashyTabBarItem(
              icon: const FaIcon(FontAwesomeIcons.solidCompass,
                  color: MyColor.primary),
              title: const Text('Discover'),
            ),
            FlashyTabBarItem(
              icon: const FaIcon(FontAwesomeIcons.solidMessage,
                  color: MyColor.primary),
              title: const Text('Chat'),
            ),
            FlashyTabBarItem(
              icon: const FaIcon(FontAwesomeIcons.solidUser,
                  color: MyColor.primary),
              title: const Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

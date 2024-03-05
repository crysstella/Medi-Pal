/*

import 'package:flutter/material.dart';
import 'package:medipal/components/favorites.dart';
import 'package:medipal/components/med_schedule.dart';
import 'package:medipal/components/profile.dart';
import 'package:medipal/components/login.dart';
import 'package:medipal/theme/theme.dart';
import 'package:unicons/unicons.dart';
import '../chatBot.dart';
import '../foodSearch.dart';
import 'homePage.dart';
import 'barPage.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<StatefulWidget> createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Drawer(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
              width: double.infinity,
              //color: MaterialTheme(textTheme).light().primaryColorLight,
              child: barHeader(context),
            ),
            const Divider(color: Colors.black12),
            const SizedBox(height: 10),
            barMenuItems(context),
            const Divider(color: Colors.black12),
            const SizedBox(height: 10),
            barInfoMenu(context),
            const Spacer(),
          ],
        )));
  }
}

Widget barHeader(BuildContext context) => IconButton(
  icon: const Icon(UniconsLine.user_circle, size: 50),
  onPressed: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BarPage(selectedIndex: 3)));
  },
);

Widget barMenuItems(BuildContext context) => Wrap(
      runSpacing: 20, // vertical spacing
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BarPage(selectedIndex: 4)));
            },
            icon: const Icon(UniconsLine.schedule, size: 38)),
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BarPage(selectedIndex: 5)));
            },
            icon: const Icon(UniconsLine.comment_alt, size: 38)),
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BarPage(selectedIndex: 6)));
            },
            icon: const Icon(UniconsLine.heart, size: 38)),
      ],
    );

Widget barInfoMenu(BuildContext context) => Wrap(
      runSpacing: 20, // vertical spacing
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BarPage(selectedIndex: 4)));
            },
            icon: const Icon(UniconsLine.setting, size: 38))
      ],
    );

*/

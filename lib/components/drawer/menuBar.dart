/*
import 'package:flutter/material.dart';
import 'package:medipal/pages/Schedule/med_schedule.dart';
import 'package:medipal/pages/Profile/profile.dart';
import 'package:unicons/unicons.dart';

*/
/* This is a drawer on the side of the app that users can access some features *//*

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<StatefulWidget> createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  int currentIndex = 3; // The drawer index will start with 3 (manually)

  */
/* Set current state when the icon is tapped. *//*

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });

  }

  // Define Profile button.
  Widget barHeader(BuildContext context) => IconButton(
        icon: const Icon(UniconsLine.user_circle, size: 50),
                onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Profile()));
        },
      );

  Widget barInfoMenu(BuildContext context) => Wrap(
        runSpacing: 20, // vertical spacing
        children: [
          IconButton(
              onPressed: () {
                */
/*Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ));*//*

              },
              icon: const Icon(UniconsLine.setting, size: 38))
        ],
      );

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Drawer(
            child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
            width: double.infinity,
            child: barHeader(context),
          ),
          const Divider(color: Colors.black12),
          const SizedBox(height: 10),
        */
/*ListTile(

          leading: Icon(UniconsLine.schedule, size: 38),
          selected: currentIndex == 3,
          onTap: () {
            // Update the state of the app
            _onItemTapped(3);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(UniconsLine.comment_alt, size: 38),
          selected: currentIndex == 4,
          onTap: () {
            // Update the state of the app
            _onItemTapped(4);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(UniconsLine.heart, size: 38),
          selected: currentIndex == 5,
          onTap: () {
            // Update the state of the app
            _onItemTapped(5);
            // Then close the drawer
            Navigator.pop(context);
          },
        ),*//*

          Wrap(runSpacing: 20, children: <Widget>[
            IconButton(
                onPressed: () {
                  _onItemTapped(3);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MedicationSchedule()),
                  );
                  */
/*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicationSchedule()));*//*

                },
                icon: const Icon(UniconsLine.schedule, size: 38)),
            IconButton(
                onPressed: () {
                  _onItemTapped(4);
                  */
/*Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ChatBot()));*//*

                },
                icon: const Icon(UniconsLine.comment_alt, size: 38)),
            IconButton(
                onPressed: () {
                  _onItemTapped(5);
                  */
/*Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Favorite()));*//*

                },
                icon: const Icon(UniconsLine.heart, size: 38))
          ]),
          const Divider(color: Colors.black12),
          const SizedBox(height: 10),
          barInfoMenu(context),
          const Spacer()
        ])));
  }
}
*/

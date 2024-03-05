/*
import 'package:flutter/material.dart';
import 'package:medipal/components/login.dart';
import 'package:medipal/components/menu_bar/bottom.dart';
import 'package:medipal/components/profile.dart';
import 'package:medipal/theme/textTheme.dart';
import 'package:medipal/theme/theme.dart';
import 'package:medipal/components/menu_bar/verticalBar.dart';
import 'package:unicons/unicons.dart';

import '../chatBot.dart';
import '../favorites.dart';
import '../med_schedule.dart';
import 'barPage.dart';

class Home extends StatefulWidget {
  int selectedIndex = 0;
  Home({required this.selectedIndex});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    _onItemTapped(widget.selectedIndex);
    super.initState();
  }

  Widget barHeader(BuildContext context) => IconButton(
        icon: const Icon(UniconsLine.user_circle, size: 50),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Profile()));
        },
      );

  Widget barMenuItems(BuildContext context) => Wrap(
        runSpacing: 20, // vertical spacing
        children: [
          IconButton(
              onPressed: () {
                _onItemTapped;
                */
/*Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MedicationSchedule()));*//*

              },
              icon: const Icon(UniconsLine.schedule, size: 38)),
          IconButton(
              onPressed: () {
                _onItemTapped;
                */
/*Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ChatBot()));*//*

              },
              icon: const Icon(UniconsLine.comment_alt, size: 38)),
          IconButton(
              onPressed: () {
                _onItemTapped;
                */
/* Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Favorite()));*//*

              },
              icon: const Icon(UniconsLine.heart, size: 38)),
        ],
      );

  Widget barInfoMenu(BuildContext context) => Wrap(
        runSpacing: 20, // vertical spacing
        children: [
          IconButton(
              onPressed: () {
                _onItemTapped;
                */
/*Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BarPage(selectedIndex: 4)));*//*

              },
              icon: const Icon(UniconsLine.setting, size: 38))
        ],
      );
  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return Scaffold(
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Drawer(
                child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                //color: MaterialTheme(textTheme).light().primaryColorLight,
                child: barHeader(context),
              ),
              const Divider(color: Colors.black12),
              const SizedBox(height: 10),
              Wrap(runSpacing: 20, children: <Widget> [
                IconButton(
                    onPressed: () {
                      _onItemTapped(3);
                      */
/*Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MedicationSchedule()));*//*

                    },
                    icon: const Icon(UniconsLine.schedule, size: 38)),
                IconButton(
                    onPressed: () {
                      _onItemTapped(4);
                      */
/*Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ChatBot()));*//*

                    },
                    icon: const Icon(UniconsLine.comment_alt, size: 38)),
                IconButton(
                    onPressed: () {
                      _onItemTapped(5);
                      */
/* Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Favorite()));*//*

                    },
                                        icon: const Icon(UniconsLine.heart, size: 38))
              ])
            ]))),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(UniconsLine.bars),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: const Center(
          child: Text('Home Page'),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 38,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              // Home
              BottomNavigationBarItem(
                  icon: Icon(UniconsLine.home), label: 'Home'),
              // Search
              BottomNavigationBarItem(
                  icon: Icon(UniconsLine.search), label: 'Search'),
              // Notifications
              BottomNavigationBarItem(
                  icon: Icon(UniconsLine.bell), label: 'Notifications'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped));
  }
}
*/

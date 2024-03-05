/*
import 'package:flutter/material.dart';
import 'package:medipal/components/chatBot.dart';
import 'package:medipal/components/favorites.dart';
import 'package:medipal/components/foodSearch.dart';
import 'package:medipal/components/med_schedule.dart';
import 'package:medipal/components/profile.dart';
import 'package:unicons/unicons.dart';

import 'homePage.dart';
import '../notification.dart';

class NavigationItem{
  final Widget page;
  final Widget title;
  final Icon icon;

  NavigationItem({required this.page, required this.title,required this.icon});

  static List<NavigationItem> get items => [
    NavigationItem(
      page: Home(),
      icon: Icon(UniconsLine.home),
      title: Text('Home')
    ),
    NavigationItem(
        page: FoodSearch(),
        icon:  Icon(UniconsLine.search),
        title: Text('Food Search')
    ),
    NavigationItem(
        page: Notifications(),
        icon: Icon(UniconsLine.bell),
        title: Text('Notifications')
    ),
    NavigationItem(
        page: Profile(),
        icon: Icon(UniconsLine.user_circle),
        title: Text('Profile')
    ),
    NavigationItem(
        page: MedicationSchedule(),
        icon: Icon(UniconsLine.schedule),
        title: Text('Schedule')
    ),
    NavigationItem(
        page: ChatBot(),
        icon: Icon(UniconsLine.comment_alt),
        title: Text('Chat Bot')
    ),
    NavigationItem(
        page: const Favorite(),
        icon: Icon(UniconsLine.heart),
        title: Text('Favorites')
    ),

  ];
}

*/
/*
import 'package:flutter/material.dart';
import 'package:medipal/components/foodSearch.dart';
import 'package:medipal/components/menu_bar/verticalBar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:unicons/unicons.dart';

import '../favorites.dart';
import '../homePage.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [const Home(), const FoodSearch(), const Favorite()];
    }

    ;

    List<PersistentBottomNavBarItem> _items() {
      return [
        PersistentBottomNavBarItem(
            icon: const Icon(UniconsLine.home), title: 'Home'),
        PersistentBottomNavBarItem(
            icon: const Icon(UniconsLine.search), title: 'Search'),
        PersistentBottomNavBarItem(
            icon: const Icon(UniconsLine.bell), title: 'Notifications')
      ];
    }

    ;

    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
        drawer: const SideBar(),
        body: PersistentTabView(
          context,
          screens: _buildScreens(),
          controller: _controller,
          items: _items(),
          confineInSafeArea: true,
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: true,
          navBarStyle: NavBarStyle.style9,
        ));
  }
}
*/


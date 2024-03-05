import 'package:flutter/material.dart';
import 'package:medipal/components/pages/ChatBot/chatBot.dart';
import 'package:medipal/components/pages/Favorites/favorites.dart';
import 'package:medipal/components/pages/Search/foodSearch.dart';
import 'package:medipal/components/pages/Schedule/med_schedule.dart';
import 'package:unicons/unicons.dart';

import '../../pages/Home/home.dart';
import '../../pages/Notification/notification.dart';
import '../../pages/Profile/profile.dart';
import '../../pages/Setting/setting.dart';

// Navigation Item or Routing Pages list contains all the pages in the navigation bars.
class NavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  NavigationItem({required this.page, required this.title, required this.icon});

  static List<NavigationItem> get items => [
        // 0
        NavigationItem(
            page: Home(), icon: Icon(UniconsLine.home), title: Text('Home')),
        // 1
        NavigationItem(
            page: FoodSearch(),
            icon: Icon(UniconsLine.search),
            title: Text('Food Search')),
        // 2
        NavigationItem(
            page: Notifications(),
            icon: Icon(UniconsLine.bell),
            title: Text('Notifications')),
        // 3
        NavigationItem(
            page: Profile(),
            icon: Icon(UniconsLine.user_circle),
            title: Text('Profile')),
        // 4
        NavigationItem(
            page: MedicationSchedule(),
            icon: Icon(UniconsLine.schedule),
            title: Text('Medication Schedule')),
        // 5
        NavigationItem(
            page: ChatBot(),
            icon: Icon(UniconsLine.comment_alt),
            title: Text('Chat bot')),
        // 6
        NavigationItem(
            page: Favorite(),
            icon: Icon(UniconsLine.heart),
            title: Text('Favorites')),
        // 7
        NavigationItem(
            page: Setting(),
            icon: Icon(UniconsLine.setting),
            title: Text('Setting')),
      ];
}

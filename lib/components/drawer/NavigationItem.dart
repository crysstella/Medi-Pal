import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../pages/ChatBot/chatBot.dart';
import '../../pages/Favorites/favorites.dart';
import '../../pages/Home/home.dart';
import '../../pages/Home/home_page.dart';

import '../../pages/Notification/notification.dart';
import '../../pages/Profile/profile.dart';
import '../../pages/Schedule/med_schedule.dart';
import '../../pages/Search/search.dart';
import '../../pages/Setting/setting.dart';

// Navigation Item or Routing Pages list contains all the pages in the navigation bars.
class NavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  NavigationItem({required this.page, required this.title, required this.icon});

  static List<NavigationItem> get items => [
        // 0
        NavigationItem(
            //page: Home(), 
            page: HomePage(), 
            icon: Icon(UniconsLine.home), 
            title: 'HOME'),
        // 1
        NavigationItem(
            page: SearchPage(),
            icon: Icon(UniconsLine.search),
            title: 'FOOD SEARCH'),
        // 2
        NavigationItem(
            page: Notifications(),
            icon: Icon(UniconsLine.bell),
            title: 'NOTIFICATIONS'),
        // 3
        NavigationItem(
            page: Profile(),
            icon: Icon(UniconsLine.user_circle),
            title: 'PROFILE'),
        // 4
        NavigationItem(
            page: MedicationSchedule(),
            icon: Icon(UniconsLine.schedule),
            title: 'MEDICATION SCHEDULE'),
        // 5
        NavigationItem(
            page: ChatBot(),
            icon: Icon(UniconsLine.comment_alt),
            title: 'CHATBOT'),
        // 6
        NavigationItem(
            page: Favorite(),
            icon: Icon(UniconsLine.heart),
            title: 'FAVORITES'),
        // 7
        NavigationItem(
            page: SettingsScreen(),
            icon: Icon(UniconsLine.setting),
            title: 'SETTINGS'),
      ];
}
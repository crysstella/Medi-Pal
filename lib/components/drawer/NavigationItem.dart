import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../pages/ChatBot/chatBot.dart';
import '../../pages/Favorites/favorites.dart';
import '../../pages/Home/home.dart';
import '../../pages/Notification/notification.dart';
import '../../pages/Profile/profile.dart';
import '../../pages/Schedule/med_schedule.dart';
import '../../pages/Search/search.dart';
import '../../pages/Setting/setting.dart';



class NavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  NavigationItem({required this.page, required this.title, required this.icon});

  static List<NavigationItem> get items => [
        // 0
        NavigationItem(
            page: const Home(), icon: const Icon(UniconsLine.home), 
            title: 'Home'),
        // 1
        NavigationItem(
            page: SearchPage(),
            icon: const Icon(UniconsLine.search),
            title: 'Food Search'),
        // 2
        NavigationItem(
            page: const Notifications(),
            icon: const Icon(UniconsLine.bell),
            title: 'Notifications'),
        // 3
        NavigationItem(
            page: const Profile(email: ""),
            icon: const Icon(UniconsLine.user_circle),
            title: 'Profile'),
        // 4
        NavigationItem(
            page: const MedicationSchedule(),
            icon: const Icon(UniconsLine.schedule),
            title: 'Schedules'),
        // 5
        NavigationItem(
            page: const ChatBot(),
            icon: const Icon(UniconsLine.comment_alt),
            title: 'Medi-Bot'),
        // 6
        NavigationItem(
            page: Favorite(),
            icon: const Icon(UniconsLine.heart),
            title: 'Favorites'),
        // 7
        NavigationItem(
            page: const SettingsScreen(),
            icon: const Icon(UniconsLine.setting),
            title: 'Settings'),
      ];
}

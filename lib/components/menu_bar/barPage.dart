/*
import 'package:flutter/material.dart';
import 'package:medipal/components/menu_bar/verticalBar.dart';
import 'package:unicons/unicons.dart';

import 'bottom.dart';

class BarPage extends StatefulWidget{
  int selectedIndex = 0;

  BarPage({required this.selectedIndex});

  @override
  _BarPageState createState() => _BarPageState();
}

class _BarPageState extends State<BarPage>{
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
      print(_selectedIndex);
    });
  }

  @override
  void initState(){
    _onItemTapped(widget.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        drawer: SideBar(),
        body: IndexedStack(
          index: widget.selectedIndex,
          children: [
            for (final item in NavigationItem.items) item.page,
          ],
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
            onTap: _onItemTapped)

    );
  }

}*/

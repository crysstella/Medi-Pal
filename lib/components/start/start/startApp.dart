import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../drawer/NavigationItem.dart';

/* Start page contains navigation bars*/
class StartApp extends StatefulWidget {
  /*int selectedIndex = 0;
  int selectedIndex_side  = 3;*/

  StartApp({super.key});

  @override
  State<StatefulWidget> createState() => StartAppState();
}

// Keep track which bar is on tapped.
enum LastTappedBar { bottomNavigationBar, drawer }

class StartAppState extends State<StartApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0; // Bottom bar starting index
  int currentIndexSide = 3; // Side bar starting index

  LastTappedBar? _lastTappedBar; // Check if the current tap is bottom or side

  // Set the index of the bottom bar
  void _onItemTappedBottom(int index) {
    setState(() {
      currentIndex = index;
      _lastTappedBar = LastTappedBar.bottomNavigationBar;
    });
  }

  // Set the index of side bar
  void _onItemTappedDrawer(int index) {
    // Close the drawer
    Navigator.pop(context);
    // Update the state to show new content
    setState(() {
      _lastTappedBar = LastTappedBar.drawer;
      currentIndexSide = index; // Change to the index of profile
      currentIndex = -1; // Unselect bottom bar
    });
  }

  // Header (profile feature) of the side bar
  Widget barHeader(BuildContext context) => IconButton(
        icon: const Icon(UniconsLine.user_circle, size: 50),
        onPressed: () {
          _onItemTappedDrawer(3);
          print(currentIndexSide);
          print(currentIndex);
        },
        isSelected:
            (currentIndexSide == 3 && currentIndex == -1) ? true : false,
      );

  // Setting button in side bar
  Widget barInfoMenu(BuildContext context) => Wrap(
          runSpacing: 20, // vertical spacing
          children: [
            IconButton(
              icon: const Icon(UniconsLine.setting, size: 38),
              onPressed: () {
                _onItemTappedDrawer(7);
                print(currentIndexSide);
                print(currentIndex);
              },
              isSelected:
                  (currentIndexSide == 7 && currentIndex == -1) ? true : false,
            )
          ]);

  // Return page corresponds to current index
  // in the Navigation Item
  Widget _getBodyWidget(int index) {
    return NavigationItem.items[index].page;
  }

  // This is how our app bars look like and the pages will be routed within this scaffold.
  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return Scaffold(
        key: _scaffoldKey,
        //drawer: SideMenu(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  UniconsLine.bars,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        drawer: SizedBox(
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
              Wrap(runSpacing: 20, children: <Widget>[
                IconButton(
                  icon: const Icon(UniconsLine.schedule, size: 38),
                  onPressed: () {
                    _onItemTappedDrawer(4);
                    print(currentIndexSide);
                    print(currentIndex);
                  },
                  isSelected: (currentIndexSide == 4 && currentIndex == -1)
                      ? true
                      : false,
                ),
                IconButton(
                  icon: const Icon(UniconsLine.comment_alt, size: 38),
                  onPressed: () {
                    _onItemTappedDrawer(5);
                    print(currentIndexSide);
                    print(currentIndex);
                  },
                  isSelected: (currentIndexSide == 5 && currentIndex == -1)
                      ? true
                      : false,
                ),
                IconButton(
                  icon: const Icon(UniconsLine.heart, size: 38),
                  onPressed: () {
                    _onItemTappedDrawer(6);
                    print(currentIndexSide);
                    print(currentIndex);
                  },
                  isSelected: (currentIndexSide == 6 && currentIndex == -1)
                      ? true
                      : false,
                )
              ]),
              const Divider(color: Colors.black12),
              const SizedBox(height: 10),
              barInfoMenu(context),
              const Spacer()
            ]))),
        // navigate the body page into the new page based on the tap
        body: Center(
          child: (_lastTappedBar == LastTappedBar.bottomNavigationBar ||
                  _lastTappedBar == null)
              ? _getBodyWidget(currentIndex)
              : _getBodyWidget(currentIndexSide),
        ),
        // Bottome navigation bar.
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 38,
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
            /* Keep track which icon is tapped at the bottom bar.
             * If not the last item at the bottom was
             * tapped still being selected with another pages. */
            currentIndex: currentIndex == -1 ? 0 : currentIndex,
            selectedItemColor: currentIndex == -1
                ? Colors.grey[600]
                : Theme.of(context).primaryColor,
            showSelectedLabels: currentIndex == -1 ? false : true,
            showUnselectedLabels: false,
            onTap: _onItemTappedBottom));
  }
}

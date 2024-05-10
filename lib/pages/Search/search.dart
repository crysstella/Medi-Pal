import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_recipe.dart';
import 'search_disease.dart';
import 'a_diseaseSearch.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<Tab> myTabs = <Tab>[
    Tab(text: 'Recipes'),
    Tab(text: 'Diseases'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFc6c6ff),
              title: TabBar(
                tabs: myTabs,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            body: const TabBarView(children: [SearchRecipe(), DiseaseSearch()])));
  }
}

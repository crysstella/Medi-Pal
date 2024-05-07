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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(  
      length: 2,  
      child: Scaffold(
        appBar: AppBar(  
          backgroundColor:  Color(0x9EA0A1FA),
          title: const Text('Search'), 
          elevation: 0.0, 
          bottom: const TabBar(
            tabs: [  
              Tab(text: "Recipes"),  
              Tab(text: "Diseases")
            ],  
          ),  
        ),  
        body: TabBarView(  
          children: [  
            SearchRecipe(),  
            //SearchDisease(),
            //SearchFood(),
            DiseaseSearch(),
          ],  
        ),  
      ),
    );
  }
}
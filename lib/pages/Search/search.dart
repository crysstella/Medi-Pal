import 'package:flutter/material.dart';
import 'recipe_search_bar.dart';
import 'a_diseaseSearch.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  static List<Tab> myTabs = <Tab>[
    const Tab(text: 'Recipes'),
    const Tab(text: 'Diseases'),
  ];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
      tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    // return Scaffold(
    //   appBar: AppBar(
    //       backgroundColor: const Color(0xFFc6c6ff),
    //   ),
    //   	body: SingleChildScrollView(
		// 		child: SizedBox(
		// 			height: MediaQuery.of(context).size.height,
		// 			child: Padding(
		// 				padding: const EdgeInsets.symmetric(horizontal: 30),
		// 				child: Column(
		// 					children: [
		// 						const SizedBox(height: kToolbarHeight),
		// 						TabBar(
		// 							controller: tabController,
		// 							unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
		// 							labelColor: Theme.of(context).colorScheme.onBackground,
		// 							tabs: const [
		// 								Padding(
		// 									padding: EdgeInsets.all(12.0),
		// 									child: Text(
		// 										'Recipes',
		// 										style: TextStyle(
		// 											fontSize: 18,
		// 										),
		// 									),
		// 								),
		// 								Padding(
		// 									padding: EdgeInsets.all(12.0),
		// 									child: Text(
		// 										'Disease',
		// 										style: TextStyle(
		// 											fontSize: 18,
		// 										),
		// 									),
		// 								),
		// 							]
		// 						),
                
		// 						Expanded(
		// 							child: TabBarView(
		// 								controller: tabController,
		// 								children: const [									
		// 										SearchRecipe(),										
		// 										DiseaseSearch(),										
		// 								]
		// 							),
		// 						)
		// 					],
		// 				),
		// 			),
		// 		),
		// 	),
    // );




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
            body: TabBarView(children: [RecipeSearchBar(), DiseaseSearch()])));



  }
} //SearchRecipePage(),
//SearchRecipe()


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_repository/search_repository.dart';
import 'package:medipal/components/recipe_images.dart';

class SearchRecipe extends StatefulWidget {
  String query;
  SearchRecipe({Key? key, required this.query}) : super(key: key);

  @override
  _SearchRecipeState createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  final searchcontroller = TextEditingController();
  bool loading = true;
  List<SearchRecipeModel> searchItem = [];
  getsearchrecipe(String query) async {
    String url =
        'https://api.edamam.com/search?q=$query&app_id=a7df912f&app_key=3eb2b5b687d167b85b4f79c47e4c9abb';
    final response = await http.get(Uri.parse(url));

    searchItem.clear();
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      SearchRecipeModel searchRecipeModel = new SearchRecipeModel();
      searchRecipeModel = SearchRecipeModel.fromMap(element["recipe"]);

      searchItem.add(searchRecipeModel);

      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    getsearchrecipe(widget.query);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results: ${widget.query}'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 23),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                      itemCount: searchItem.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),

                              // child: Inkwell(
                              //   onTap: () {
                              //     Navigator.push(context, MaterialPageRoute(builder: (context)
                              //     =>RecipeDetail(baseurl: searchItem[index].recipeSource.toString(),)));
                              //   },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    child: RecipeImageComponent(
                                        image: searchItem[index]
                                            .recipeImage
                                            .toString()),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer
                                            .withOpacity(.9),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          searchItem[index]
                                              .recipeName
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }),
                )
              ],
            ),
      //)
    );
    //  return Column(
    //    children: [
    //      Container(
    //        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    //        color: const Color(0xFFEEEAFD),
    //        child: Row(
    //          children: [
    //            Expanded(

    //             //search bar
    //              child: TextField(
    //                //controller: controller,
    //                style: TextStyle(
    //                  color: Theme.of(context).primaryColor,
    //                ),
    //                decoration: const InputDecoration(
    //                  hintText: "Search for recipes...",
    //                  hintStyle: TextStyle(
    //                    color: Colors.grey,
    //                    fontSize: 14,
    //                  ),
    //                  border: InputBorder.none
    //                ),
    //              ),
    //            ),
    //            InkWell(
    //             onTap: () {

    //             },
    //             child: const Icon(UniconsLine.search, color: Colors.white)
    //            ),

    //           //list view
    //            Expanded(
    //             child: ListView.builder(

    //                itemCount: controller.itemList.length,
    //                itemBuilder: (context, index) {

    //                 return Padding(
    //                   padding: const EdgeInsets.all(8),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(16),
    //                     child: Stack(
    //                       children: [
    //                         Container(
    //                           height: 300,
    //                           width: MediaQuery.of(context).size.width,
    //                           decoration: BoxDecoration(
    //                            color: Theme.of(context).colorScheme.background,
    //                           ),
    //                           child: Image.network(controller.itemList[index].recipeImage.toString(), fit: BoxFit.fill,),
    //                         ),

    //                         Positioned(
    //                           bottom: 0,
    //                           child:
    //                             Container(
    //                               height: 300,
    //                               width: MediaQuery.of(context).size.width,
    //                               decoration: BoxDecoration(
    //                                 color: Theme.of(context).colorScheme.secondaryContainer,
    //                               ),
    //                               child: Text(controller.itemList[index].recipeName.toString(), style: TextStyle(
    //                                 fontWeight: FontWeight.w600, fontSize: 20 ),),
    //                             ),
    //                         ),

    //                       ],
    //                     ),
    //                   )
    //                 );

    //               }),

    //            )
    //          ],

    //        ),
    //      )
    //    ]
    //  );
  }
}

// import 'package:search_repository/search_repository.dart';
// import 'package:unicons/unicons.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

//  class SearchRecipe extends StatefulWidget {
//   const SearchRecipe({super.key});

//   @override
//   _SearchRecipeState createState() => _SearchRecipeState();
// }

// class _SearchRecipeState extends State<SearchRecipe> {
//   final SearchRecipeRepository _repository = SearchRecipeRepository();
//   TextEditingController _searchEditingController = TextEditingController();
//   bool _isLoading = false;
//   bool _hasSearched = false;
//   List<String> _searchResults = [];

//   void _searchRecipes(String query) async {
//     setState(() {
//       _isLoading = true;
//       _hasSearched = true;
//     });

//     try {
//       //final repository = SearchRecipeRepository();
//       final recipes = await _repository.searchRecipes(query);
//       setState(() {
//         _searchResults = recipes;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         _isLoading = false;
//         _hasSearched = false;
//       });
//     }

//   }

//   Widget recipeList() {
//     return _hasSearched ? (_searchResults.isEmpty) ?
//     Padding(
//       padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//       child: Center(child: Text('No results available...')),
//     )
//     :
//     ListView.builder(
//       shrinkWrap: true,
//       itemCount: _searchResults.length,
//       itemBuilder: (context, index) {

//         final recipe = _searchResults[index];
//         return GestureDetector (
//           onTap: () {},
//           child: ListTile(
//               title: Text(recipe.title),
//               subtitle: Text('${recipe.kcal} Calories'),
//                       ),
//         );
//         // return Column(
//         //   children: [
//         //     Padding(
//         //       padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),

//         //       child: Text(
//         //         _searchEditingController.text,
//         //         style: TextStyle(
//         //           fontWeight: FontWeight.bold,
//         //           fontSize: 14.0,
//         //         ),
//         //       ),

//         //     ),
//         //     ListTile(
//         //       title: Text(recipe.title),
//         //     ),
//         //     Container(
//         //       padding: EdgeInsets.symmetric(horizontal: 20.0),
//         //       child: Divider(height: 0.0)
//         //     ),
//         //   ],
//         // );

//       }
//     )
//   : Container();
//   }

//    @override
//    Widget build(BuildContext context) {
//      return Container(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//             color: const Color(0x9EA0A1FA),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchEditingController,
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: "Search for recipes...",
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                       border: InputBorder.none
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: (){
//                     _searchRecipes(_searchEditingController.text);
//                   },
//                   child: Container(
//                     height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: const Color(0x9EA0A1FA),
//                         borderRadius: BorderRadius.circular(40)
//                       ),
//                       child: const Icon(UniconsLine.search, color: Colors.white)
//                   )
//                 )
//               ],
//             ),
//           ),

//           _isLoading ? Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//             child: Center(child: CircularProgressIndicator()),
//           ) : recipeList()

//         ]
//       ),
//     );
//   }
// }

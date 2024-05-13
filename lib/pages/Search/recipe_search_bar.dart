import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'search_recipe.dart';

class RecipeSearchBar extends StatelessWidget {
  RecipeSearchBar({Key? key}) : super(key: key);
  final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            child: Row(
             children: [
              Expanded(
                child: TextField(
                  controller: searchcontroller,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                  decoration: InputDecoration(
                    hintText: 'Search for a recipe...',
                    hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                  onTap: (){
                    if(searchcontroller.text == ''){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('no results..')));
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>SearchRecipe(query: searchcontroller.text))).then((value) => {
                        searchcontroller.clear()
                      });
                    }
                  },
                  child: const Icon(UniconsLine.search)),
            ],

            ),
          ),
        ],
      ),

      )
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border.all()
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: TextField(
    //               controller: searchcontroller,
    //               decoration: InputDecoration(
    //                 hintText: 'Search for recipes',
    //                 border: InputBorder.none,
    //                 focusedBorder: InputBorder.none,
    //                 enabledBorder: InputBorder.none,
    //               ),
    //             ),
    //           ),
    //           InkWell(
    //               onTap: (){
    //                 if(searchcontroller.text == ''){
    //                   ScaffoldMessenger.of(context).showSnackBar(
    //                       SnackBar(content: Text('no results..')));
    //                 }
    //                 else{
    //                   Navigator.push(context, MaterialPageRoute(builder:
    //                       (context)=>SearchRecipe(query: searchcontroller.text))).then((value) => {
    //                     searchcontroller.clear()
    //                   });
    //                 }
    //               },
    //               child: const Icon(UniconsLine.search)),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

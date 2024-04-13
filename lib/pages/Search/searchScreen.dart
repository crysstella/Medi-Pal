// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:unicons/unicons.dart';

// import 'foodSearch.dart';
// import 'search_food.dart';

//  class SearchScreen extends StatefulWidget {
//   final String userEmail = "a@gmail.com";
//     //initalize the userSearch as input from search
//   final String userSearch;
//   //initialize the fb documentID
//   final String userSearchID;


//     //set the document ID to call it from fb
//   const SearchScreen({super.key, this.userSearchID = "2O1FKL6tcyXKC8v3GPIS", required this.userSearch});

//   //const SearchScreen({super.key});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {

//   String _inputValue = "";
//   TextEditingController searchController = TextEditingController();
//   List<String> resultFoods = [];

//   //function to get the collection Search Information from db
//   Future<Map<String, dynamic>> _getAllFoodSearch(String userSearchID) async {
//     var collection = FirebaseFirestore.instance.collection("Food Database");
//     var document = await collection.doc(userSearchID).get();

//     if (document.exists) {
//       //return map of arrays
//       return document.data() as Map<String, dynamic>;
//     } else {
//       throw Exception("Could not be found");
//     }
//   }

//   // void _initiateSearch() {
//   //   //searchController.addListener(_onSearchChanged);
//   //   //if input is not null
//   //   if (_inputValue.isNotEmpty) {
//   //     Navigator.push(
//   //           context,
//   //           MaterialPageRoute(
//   //               builder: (context) =>
//   //               //passes in the userInput
//   //                 FoodSearchScreen(userSearch: _inputValue)));
//   //     }
//   //     else {
//   //       throw (error) {
//   //         print("Failed to save input: $error");
//   //         };
//   //     }
//   // }



//   @override
//   Widget build(BuildContext context) {
//       return Scaffold(  
//         appBar: AppBar(  
//           title: const Text(
//             'Enter in a disease to see some suggested foods: ',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),  
//             ),
//         ),  

//               //call getAllFoodSearch
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _getAllFoodSearch(widget.userSearchID),
//         builder: (context, snapshot) {
//           //after calling returns a progress bar until this screen starts
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             ); 
//             } else if (snapshot.hasData) {
//             var foodData = snapshot.data!;
//             //find if the key of userDisease is in the food information database
//             if (!foodData.containsKey(widget.userSearch)) {
//               return Center(
//                 child: Text("Data not available for ${widget.userSearch}"),
//               );
//             }
//             // //gets the array matching the diseases int the food information db
//             // var foodInfo = foodData[widget.userSearch] as List<dynamic>;

//             return 
//             Column( 
//             children: [  
//               //SearchFood(),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
//                 color: const Color(0x9EA0A1FA),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         onChanged: (newValue) {
//                           setState((){
//                             _inputValue = newValue;
//                           });                                              
//                         },
//                         controller: searchController,
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                         decoration: InputDecoration(
//                           hintText: "Start typing to search..",
//                           hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                           border: InputBorder.none
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: (){
//                        if (_inputValue != null) {
//                       setState(() {
//                         //adds food to array
//                         //resultFoods.add(_inputValue!);
//                           Navigator.push(
//                           context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                 FoodSearchScreen(userSearch: _inputValue))); 
//                       });
//                       }   
//                         // Navigator.push(
//                         //   context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) =>
//                         //         FoodSearchScreen(userSearch: _inputValue))); //passes in the userInput
//                         //_initiateSearch();
//                       },
//                       child: Container(
//                         height: 30,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(158, 255, 255, 255),
//                             border: Border.all(
//                               color: const Color(0x9EA0A1FA),
//                             ),
//                             borderRadius: BorderRadius.circular(40)
//                           ),
//                           child: Icon(UniconsLine.search, color: const Color(0x9EA0A1FA))
//                       )
//                     )
//                   ],
//                 ),
//               ),],
//               );
//           } else {
//             return const Center(
//               child: Text("Error"),
//             );
//           }
//           // find if snapshot has any elements
           
//           // } else if (snapshot.hasError) {
//           //     return Text("Error: ${snapshot.error}");
//           // } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//           //     return const Text("No data available for this search");
//           // } else {
//           //     //set search result as data
//           //     var searchResultSnapshot = snapshot.data!;
//           //     //set medicinetypes and sorts the array
//           //     var searchArr = searchResultSnapshot.keys.toList()..sort();
//           //     return ListView.builder(
//           //       itemCount: searchArr.length,
//           //       itemBuilder: (context, index) {
//           //         //get each value of user search from results snapshot
//           //         var userSearch = searchResultSnapshot[index];

//           //         // Check if 'user search' is actually a List
//           //         if (userSearch is! List) {
//           //           userSearch = ["Invalid data format for $userSearch"];
//           //         }

//           //         return ExpansionTile(
//           //           title: Text(
//           //             '$userSearch',
//           //             style: const TextStyle(fontWeight: FontWeight.bold),
//           //           ),
//           //           children: List<Widget>.from(userSearch.map((item) {
//           //             return FutureBuilder<Map<String, dynamic>>(
//           //               future: _getAllFoodSearch(userSearchID, item),
//           //               builder: (context, snapshot) {
//           //                 if (snapshot.connectionState ==
//           //                     ConnectionState.waiting) {
//           //                   return const CircularProgressIndicator();
//           //                 } else if (snapshot.hasError) {
//           //                   return Text("Error: ${snapshot.error}");
//           //                 } else {
//           //                   var foodInfo = snapshot.data!;
//           //                   var array = foodInfo[item] as List?;
//           //                   if (array != null) {
//           //                     return ListTile(
//           //                       title: Text(
//           //                         "•" + item,
//           //                         style: const TextStyle(fontSize: 16), 
//           //                       ),
//           //                     );
//           //                   } else {
//           //                     return const Text("No array found");
//           //                   }
//           //                 }
//           //               },
//           //             );
//           //           })),
//           //         );
//           //       },
//           //     );
//           // }
//         },
//       ),
//         // body: Container(
//         //   child: Column(
//         //     children: [  
//         //       //SearchFood(),
//         //       Container(
//         //         padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
//         //         color: const Color(0x9EA0A1FA),
//         //         child: Row(
//         //           children: [
//         //             Expanded(
//         //               child: TextField(
//         //                 onChanged: (value) {
//         //                   setState((){
//         //                     _inputValue = value;
//         //                   });
//         //                 },
//         //                 controller: searchController,
//         //                 style: TextStyle(
//         //                   color: Colors.white,
//         //                 ),
//         //                 decoration: InputDecoration(
//         //                   hintText: "Start typing to search..",
//         //                   hintStyle: TextStyle(
//         //                     color: Colors.grey,
//         //                     fontSize: 14,
//         //                   ),
//         //                   border: InputBorder.none
//         //                 ),
//         //               ),
//         //             ),
//         //             GestureDetector(
//         //               onTap: (){
//         //                 Navigator.push(
//         //                   context,
//         //                     MaterialPageRoute(
//         //                       builder: (context) =>
//         //                         FoodSearchScreen(userSearch: _inputValue))); //passes in the userInput
//         //                 //_initiateSearch();
//         //               },
//         //               child: Container(
//         //                 height: 30,
//         //                   width: 40,
//         //                   decoration: BoxDecoration(
//         //                     color: Color.fromARGB(158, 255, 255, 255),
//         //                     border: Border.all(
//         //                       color: const Color(0x9EA0A1FA),
//         //                     ),
//         //                     borderRadius: BorderRadius.circular(40)
//         //                   ),
//         //                   child: Icon(UniconsLine.search, color: const Color(0x9EA0A1FA))
//         //               )
//         //             )
//         //           ],
//         //         ),
//         //       ),
//         //       // Container(
//         //       //   padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
//         //       // ),
              
//         //   ],  
//         //   ),
//         // ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>_SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Search')]),
      ),
    );
  }
}

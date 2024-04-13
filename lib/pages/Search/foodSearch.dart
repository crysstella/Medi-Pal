// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FoodSearchScreen extends StatelessWidget {
//   // const FoodSearchScreen({super.key});

//   //initalize the userSearch as input from search
//   final String userSearch;
//   //initialize the fb documentID
//   final String userSearchID;



//   const FoodSearchScreen(
//     //set the document ID to call it from fb
//     {super.key, this.userSearchID = "2O1FKL6tcyXKC8v3GPIS", required this.userSearch});

//   //function to get the collection Search Information from db
//   Future<Map<String, dynamic>> _getAllFoodSearch(String userSearchID) async {
//     var collection = FirebaseFirestore.instance.collection("Food Database");
//     //get the information
//     var document = await collection.doc(userSearchID).get();

//     if (document.exists) {
//       //return map of arrays
//       return document.data() as Map<String, dynamic>;
//     } else {
//       throw Exception("Could not be found");
//     }
//   }

//   @override
//   //build the foodSearch screen
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(userSearch),
//       ),

//       //call getAllFoodSearch
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _getAllFoodSearch(userSearchID),
//         builder: (context, snapshot) {
//           //after calling returns a progress bar until this screen starts
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             ); 
//           // find if snapshot has any elements
//           } else if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//           } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//               return const Text("No data available for this search");
//           } else {
//               //set search result as data
//               var searchResultSnapshot = snapshot.data!;
//               //set medicinetypes and sorts the array
//               var searchArr = searchResultSnapshot.keys.toList()..sort();
//               return ListView.builder(
//                 itemCount: searchArr.length,
//                 itemBuilder: (context, index) {
//                   //get each value of user search from results snapshot
//                   var userSearch = searchResultSnapshot[index];

//                   // Check if 'user search' is actually a List
//                   if (userSearch is! List) {
//                     userSearch = ["Invalid data format for $userSearch"];
//                   }

//                   return ExpansionTile(
//                     title: Text(
//                       '$userSearch',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     children: List<Widget>.from(userSearch.map((item) {
//                       return FutureBuilder<Map<String, dynamic>>(
//                         future: _getAllFoodSearch(userSearchID, item),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const CircularProgressIndicator();
//                           } else if (snapshot.hasError) {
//                             return Text("Error: ${snapshot.error}");
//                           } else {
//                             var foodInfo = snapshot.data!;
//                             var array = foodInfo[item] as List?;
//                             if (array != null) {
//                               return ListTile(
//                                 title: Text(
//                                   "•" + item,
//                                   style: const TextStyle(fontSize: 16), 
//                                 ),
//                               );
//                             } else {
//                               return const Text("No array found");
//                             }
//                           }
//                         },
//                       );
//                     })),
//                   );
//                 },
//               );

//           // } else if (snapshot.hasData) {
//           //   //intializes the searchData to snapshot.data(fb collection of data)
//           //   var searchData = snapshot.data!;
//           //   // does not contain the key it will return that the data is not available
//           //   if (!searchData.containsKey(userSearch)) {
//           //     return Center(
//           //       child: Text("Data not available for $userSearch"),
//           //     );
//           //   }
//           //   //intialize search info as an array
//           //   var foodSearch = searchData[userSearch] as List<dynamic>;
//           //   //call formatData function on foodSearch then returns in a better format
//           //   var formattedData = _formatData(foodSearch);
//           //   return ListView.builder(
//           //     itemCount: formattedData.length,
//           //     //index acts as interator
//           //     itemBuilder: (context, index) {
//           //       return ListTile(
//           //           title: Card(
//           //             //formatting to make the data look nicer
//           //               child: Padding(
//           //                   padding: const EdgeInsets.all(16.0),
//           //                   child: Text(
//           //                     //call/ returns indexes of formattedData here
//           //                     formattedData[index],
//           //                     style: const TextStyle(fontSize: 16.0),
//           //                   ))));
//           //     },
//           //   );
//           // } else {
//           //   return const Center(
//           //     child: Text("Error"),
//           //   );
//           }
//         },
//       ),
//     );
//   }

//   // returns a list of strings, passes in list of dynamic
//   List<String> _formatData(List<dynamic> data) {
//     // initalize array
//     List<String> foodRec = [];
//     // //initalize index
//      int foodIndex = 0;

//     //runs thru the for loop 
//     for (int i = 0; i < data.length; i++) {
//       if (data[i] != 0) {
//         foodIndex = i;
//       }
//     }
//         // add elements from food index until the length of the data
//     for (int i = foodIndex; i < data.length; i++) {
//       foodRec.add(data[i].toString());
//     }
//     //add newspace after for formatting 
//     foodRec.add("\n");
//     return foodRec;
//   }


// }


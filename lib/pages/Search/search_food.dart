// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:unicons/unicons.dart';



// class SearchFood extends StatefulWidget {
//   const SearchFood({super.key});


//   @override
//   _SearchFoodState createState() => _SearchFoodState();
// }

// class _SearchFoodState extends State<SearchFood> {

//   final String foodNameID = "2O1FKL6tcyXKC8v3GPIS";

//   //gets info from food db
//   searchFoodByName(String foodNameID) async {
//     var collection = FirebaseFirestore.instance.collection("Food Database");
//     var document = await collection.doc(foodNameID).get();

//     if (document.exists) {
//       final snapshot = document.data()!;
//       return snapshot;
//     } else {
//       throw Exception("Could not be found");
//     }
//   }
   
//   TextEditingController searchEditingController = new TextEditingController();
//   //late List<String> searchResultSnapshot;
//   dynamic searchResultSnapshot;
//   bool _isLoading = false;
//   bool _hasFoodSearched = false;

//   //final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

//   _initiateSearch() async {
//     if(searchEditingController.text.isNotEmpty){
//       setState(() {
//         _isLoading = true;
//       });
//       await searchFoodByName(searchEditingController.text).then((snapshot) {
//         searchResultSnapshot = snapshot;  
//         // print(searchResultSnapshot.documents.length);
//         setState(() {
//           _isLoading = false;
//           _hasFoodSearched = true;
//         });
//       });
//     }
//   }

//   Widget searchFoodList() {
//     return _hasFoodSearched ? (searchResultSnapshot.documents.length == 0) ? 
//     Padding(
//       padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//       child: Center(child: Text('No results found...')),
//     )
//     : 
//     ListView.builder(
//       shrinkWrap: true,
//       itemCount: searchResultSnapshot.documents.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: <Widget>[
//             InkWell(
//               // onTap: () {
//               //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserDetailsPage(userId: searchResultSnapshot.documents[index].data['userId'], fullName: searchResultSnapshot.documents[index].data['fullName'], email: searchResultSnapshot.documents[index].data['email'],)));
//               // },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
//                 child: ListTile(
//                   leading: const Icon(UniconsLine.save),
//                   title: Text(
//                     searchResultSnapshot.documents[index].data['foodName'],
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Divider(height: 0.0)
//             ),
//           ],
//         );
//       }
//     )
//   :
//   Container();
//   }

//    @override
//    Widget build(BuildContext context) {
//      return Container(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
//             color: const Color(0x9EA0A1FA),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: searchEditingController,
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                     decoration: InputDecoration(
//                       hintText: "Start typing to search..",
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
//                     _initiateSearch();
//                   },
//                   child: Container(
//                     height: 30,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(158, 255, 255, 255),
//                         border: Border.all(
//                           color: const Color(0x9EA0A1FA),
//                         ),
//                         borderRadius: BorderRadius.circular(40)
//                       ),
//                       child: Icon(UniconsLine.search, color: const Color(0x9EA0A1FA))
//                   )
//                 )
//               ],
//             ),
//           ),
//           _isLoading ? Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//             child: Center(child: CircularProgressIndicator()),
//           ) : searchFoodList()
//         ]
//       ),
//     ); 
//   }
// }
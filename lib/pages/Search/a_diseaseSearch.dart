// import 'package:unicons/unicons.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

//  class SearchFood extends StatefulWidget {
//   const SearchFood({super.key});
//   //const SearchDisease({Key key}) : super(key: key);


//   @override
//   _SearchFoodState createState() => _SearchFoodState();
// }

// class _SearchFoodState extends State<SearchFood> {
   
//   TextEditingController _searchEditingController = TextEditingController();
//   bool _isLoading = false;
//   bool _hasSearched = false;
//   List<String> _searchResults = [];


//   _initiateSearch() async {

//     setState(() {
//       _isLoading = true;
//       _hasSearched = true;
//     });

//     final diseaseName = _searchEditingController.text.toLowerCase();

//     if(diseaseName.isNotEmpty){
//       try{
//         final snapshot = await FirebaseFirestore.instance
//           .collection('Food Database')
//           .doc('2O1FKL6tcyXKC8v3GPIS')
//           .get();

//         if (snapshot.exists) {
//           final data = snapshot.data();
//           if (data != null) {
//             final diseaseData = data[diseaseName];
//             if (diseaseData != null && diseaseData is List) {
//               setState(() {
//                 _searchResults = List<String>.from(diseaseData);
//                 _isLoading = false;
//               });
//               return; // Exit the function since search is successful
//             }
//           }
//         }
//         setState(() {
//             _searchResults = [];
//             _isLoading = false;
//         });
//       } catch (error) {
//         print("Error fetching data: $error");
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//           setState(() {
//             _searchResults = [];
//             _isLoading = false;
//           });
//         } 
//     }



//   Widget foodRecList() {
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
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
//               child: Text(
//                 _searchEditingController.text,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.0,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text(_searchResults[index]),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               child: Divider(height: 0.0)
//             ),
//           ],
//         );
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
//                       hintText: "Search diseases for food recommendations...",
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
//           ) : foodRecList()
//         ],
//       ),
//     );
//   }
// }
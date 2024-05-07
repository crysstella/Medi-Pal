import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicons/unicons.dart';
import '../../shared_preferences.dart';

class DiseaseSearch extends StatefulWidget {
  final String foodID;

  DiseaseSearch({
    Key? key,
    this.foodID = "2O1FKL6tcyXKC8v3GPIS",
  }) : super(key: key);

  @override
  State<DiseaseSearch> createState() => _DiseaseSearchState();
}

class _DiseaseSearchState extends State<DiseaseSearch> {
  String? _userDisease;
  //List<String> favoriteFoods = [];
  //String? _selectedFood;

  TextEditingController _searchEditingController = TextEditingController();
  bool _isLoading = false;
  bool _hasSearched = false;
  List<String> _searchResults = [];

  // Future<QuerySnapshot>? foodDocList;
  // String diseaseText = '';

  @override
  void initState() {
    super.initState();
  }

  // initSearchDisease (String textEntered) async{
  //   foodDocList = FirebaseFirestore.instance
  //       .collection('Food Database')
  //       //.doc('2O1FKL6tcyXKC8v3GPIS')
  //       .where("foodID", isGreaterThanOrEqualTo: textEntered)
  //       .get();
  //   setState(() {   
  //   _isLoading = true;
  //   _hasSearched = true;
  //   foodDocList;
  //   });

  // }

  Future<void> _searchFoods(String diseaseName) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Food Database')
          .doc(widget.foodID)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null) {
          final diseaseData = data[diseaseName];
          if (diseaseData != null && diseaseData is List) {
            setState(() {
              _searchResults = List<String>.from(diseaseData);
            });
            return; // Exit the function since search is successful
          }
        }
      }

      // If no data found for the query, reset search results
      setState(() {
        _searchResults = [];
      });
    } catch (error) {
      print("Failed to search foods: $error");
      setState(() {
        _searchResults = [];
      });
    }
  }

  //   _initiateSearch() async {

  //   setState(() {
  //     _isLoading = true;
  //     _hasSearched = true;
  //   });

  //   if(_searchEditingController.text.isNotEmpty){
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('Food Database')
  //       .doc('2O1FKL6tcyXKC8v3GPIS')
  //       .get();

  //     if (snapshot.exists) {
  //       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //       String diseaseName = _searchEditingController.text.toLowerCase();

  //       if (data.containsKey(diseaseName)) {
  //         setState(() {
  //           _searchResults = List<String>.from(data[diseaseName]);
  //           _isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           _searchResults = [];
  //           _isLoading = false;
  //         });
  //       } 
  //     }
  //   }
  // }

  Widget buildSearchResults(List<String> searchResults) {
  if (searchResults.isEmpty) {
    return Center(
      child: Text('No results available...'),
    );
  } else {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]),
        );
      },
    );
  }
}


   @override
   Widget build(BuildContext context) {
     return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            color: const Color(0x9EA0A1FA),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchEditingController,
                    // onChanged: (textEntered){
                    //   setState(() {
                    //     diseaseText = textEntered;
                    //   });
                    //   initSearchDisease(textEntered);
                    // },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search diseases for food recommendations...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(UniconsLine.search, color: Colors.white),
                        onPressed: () {
                          //Provider.of(context, listen: false);
                          _searchFoods(_searchEditingController.text.trim());
                        }
                       
                          //initSearchDisease(diseaseText);
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          _isLoading ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: Center(child: CircularProgressIndicator()),
          ) : buildSearchResults(_searchResults),
        ]
      ),
    );
  }
}
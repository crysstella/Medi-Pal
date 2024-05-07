import 'package:unicons/unicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

 class SearchDisease extends StatefulWidget {
  const SearchDisease({super.key});


  @override
  _SearchDiseaseState createState() => _SearchDiseaseState();
}

  // final foodCollection = 'Food Database';
  // final foodID = '2O1FKL6tcyXKC8v3GPIS';

class _SearchDiseaseState extends State<SearchDisease> {
   
  TextEditingController _searchEditingController = TextEditingController();
  bool _isLoading = false;
  bool _hasSearched = false;
  List<String> _searchResults = [];

  //late List<Map<String, dynamic>> items;

  _initiateSearch() async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    if(_searchEditingController.text.isNotEmpty){
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Food Database')
        .doc('2O1FKL6tcyXKC8v3GPIS')
        .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String diseaseName = _searchEditingController.text.toLowerCase();

        if (data.containsKey(diseaseName)) {
          setState(() {
            _searchResults = List<String>.from(data[diseaseName]);
            _isLoading = false;
          });
        } else {
          setState(() {
            _searchResults = [];
            _isLoading = false;
          });
        } 
      }
    }
  }


  Widget foodRecList() {
    return _hasSearched ? (_searchResults.isEmpty) ? 
    Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: Center(child: Text('No results available...')),
    )
    : 
    ListView.builder(
      shrinkWrap: true,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Text(
                _searchEditingController.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            ListTile(
              title: Text(_searchResults[index]),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 0.0)
            ),
          ],
        );
      }
    )
  : Container();
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
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search diseases for food recommendations...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _initiateSearch();
                  },
                  child: Container(
                    height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0x9EA0A1FA),
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: const Icon(UniconsLine.search, color: Colors.white)
                  )
                )
              ],
            ),
          ),
          _isLoading ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: Center(child: CircularProgressIndicator()),
          ) : foodRecList()
        ]
      ),
    );
  }
}
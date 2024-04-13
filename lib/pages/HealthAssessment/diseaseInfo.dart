import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseInfoScreen extends StatelessWidget {
  //initalize the userDisease from the input in main.dart
  final String userDisease;
  //initialize the fb documentID
  final String userDiseaseID;

  const DiseaseInfoScreen(
    //set the document ID to call it from fb
      {super.key, this.userDiseaseID = "EO1oWhfvlkMICXgg0JqI", required this.userDisease});

  //function to get the collection Disease Information from db
  
  Future<Map<String, dynamic>> _getAllDiseaseInfo(String userDiseaseID) async {
    //initalize the variable to the collection
    var collection =
        FirebaseFirestore.instance.collection("Disease Information");
    //get the information
    var document = await collection.doc(userDiseaseID).get();

    if (document.exists) {
      //return map of arrays
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  @override
  //build th diseaseInfo screen
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userDisease),
      ),
      //call getAllDiseaseInfo
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getAllDiseaseInfo(userDiseaseID),
        builder: (context, snapshot) {
          //after calling returns a progress bar until this screen starts
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            //find if snapshot has any elements
          } else if (snapshot.hasData) {
            //intializes the diseaseData to snapshot.data(fb collection of data)
            var diseaseData = snapshot.data!;
            // does not contain the key it will return that the data is not available
            if (!diseaseData.containsKey(userDisease)) {
              return Center(
                child: Text("Data not available for $userDisease"),
              );
            }
            //intialize diseseAinfo as an array
            var diseaseInfo = diseaseData[userDisease] as List<dynamic>;
            //call formatData function on diseaseInfo then returns in a better format
            var formattedData = _formatData(diseaseInfo);
            return ListView.builder(
              itemCount: formattedData.length,
              //index acts as interator
              itemBuilder: (context, index) {
                return ListTile(
                    title: Card(
                      //formatting to make the data look nicer
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              //call/ returns indexes of formattedData here
                              formattedData[index],
                              style: const TextStyle(fontSize: 16.0),
                            ))));
              },
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  // returns a list of strings, passes in list of dynamic
  List<String> _formatData(List<dynamic> data) {
    // initalize two arrays
    List<String> foodRec = [];
    List<String> foodAvoid = [];
    //initalize index
    int avoidIndex = 0;

    //runs thru the for loop once to find where the string element is equal to "Foods to Avoid"
    for (int i = 0; i < data.length; i++) {
      if (data[i] == ("Foods to Avoid:")) {
        //set avoidIndex to i
        avoidIndex = i;
      }
    }
    //add elements to foodRec until it hits avoid index
    for (int i = 0; i < avoidIndex; i++) {
      foodRec.add(data[i].toString());
    }
    // add elements to foodAvoid from avoid index until the length of the data
    for (int i = avoidIndex; i < data.length; i++) {
      foodAvoid.add(data[i].toString());
    }
    //add newspace after for formatting 
    foodRec.add("\n");
    // recombine the list after
    List<String> formatList = foodRec + foodAvoid;
    return formatList;
  }
}

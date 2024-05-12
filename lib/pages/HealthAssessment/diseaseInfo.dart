import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseInfoScreen extends StatelessWidget {
   //initalize the userDisease from the input in main.dart
  final String userDisease;
  //initialize the fb documentID
  final String userDiseaseID;
  //set the document ID to call it from fb
  DiseaseInfoScreen({this.userDiseaseID = "EO1oWhfvlkMICXgg0JqI", required this.userDisease});

   //function to get the collection Disease Information from db
  Future<Map<String, dynamic>> _getAllDiseaseInfo(String userDiseaseID) async {
    //initalize the variable to the collection
    var collection = FirebaseFirestore.instance.collection("Disease Information");
    //get the information
    var document = await collection.doc(userDiseaseID).get();

    if (document.exists) {
      //return map of arrays
      var diseaseData = document.data() as Map<String, dynamic>;

      // Normalize keys by removing spaces and apostrophes
      diseaseData = diseaseData.map((key, value) =>
          MapEntry(key.toLowerCase().replaceAll(' ', '').replaceAll("'", ""), value));
      return diseaseData;
    } else {
      throw Exception("Document not found for $userDisease");
    }
  }

  @override
  //build th diseaseInfo screen
  Widget build(BuildContext context) {
    String alphaDisease = alpha(userDisease);
    return Scaffold(
      appBar: AppBar(
        title: Text(alphaDisease),
      ),
      //call getAllDiseaseInfo
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getAllDiseaseInfo(userDiseaseID),
        builder: (context, snapshot) {
          //after calling returns a progress bar until this screen starts
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
          //find if snapshot has any elements
          else if (snapshot.hasData) {
             //intializes the diseaseData to snapshot.data(fb collection of data)
            var diseaseData = snapshot.data!;
            String disease = userDisease.toLowerCase().replaceAll(' ', '').replaceAll("'", "");
             // does not contain the key it will return that the data is not available
            if (!diseaseData.containsKey(disease)) {
              return Center(
                child: Text("Data not available for $userDisease"),
              );
            }
            //call formatData on the output of diseaseData[disease](dictionary)
            var formattedData = _formatData(diseaseData[disease]);
            //gets the first array
            List<String> foodRec = formattedData[0];
            //gets the second array
            List<String> foodAvoid = formattedData[1];

            //builds two outputs for foodRec and foodAvoid
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //formatting to make the data look nicer
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Foods Recommended:",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        //returns the array of foodRec
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildFoodList(foodRec),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Foods to Avoid:",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        //return foodAvid as output
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildFoodList(foodAvoid),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  //function adds padding to every food child
  List<Widget> _buildFoodList(List<String> foods) {
    return foods.map((food) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(food),
    )).toList();
  }

// returns a list of strings, passes in list of dynamic
List<List<String>> _formatData(List<dynamic> data) {
  // initalize two arrays
  List<String> foodRec = [];
  List<String> foodAvoid = [];
  //initalize index
  int avoidIndex = 0;
  //runs thru the for loop once to find where the string element is equal to "Foods to Avoid"
  for (int i = 0; i < data.length; i++) {
    if (data[i] == "Foods to Avoid:") {
      //set avoidIndex to i then breaks
      avoidIndex = i;
      //stops foodRec from adding when it hits Foods to Avoid
      break;
    }

    
    if (data[i] != "Foods Recommended:") {
      foodRec.add(data[i].toString());
    }
  }
  // add elements to foodAvoid from avoid index until the length of the data
  for (int i = avoidIndex; i < data.length; i++) {
    if (data[i] != "Foods to Avoid:") {
      foodAvoid.add(data[i].toString());
    }
  }
  //return a matrix
  return [foodRec, foodAvoid];
}
String alpha(String userDisease) {
  for (int i = 0; i < userDisease.length; i++) {
    if (userDisease[i] == " ") {
      String alphaDisease = userDisease[0].toUpperCase() + userDisease.substring(1, i) + " " + userDisease[i + 1].toUpperCase() +
      userDisease.substring(i + 2, userDisease.length);
      return alphaDisease;
    }
  }

  // If no space is found, capitalize the entire string and return
  return userDisease[0].toUpperCase() + userDisease.substring(1);
}

}
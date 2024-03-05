/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseInfoScreen extends StatelessWidget {
  //initialize the userDisease and userDiseaseID, ID is final so it never gets affected
  //userDisease is the same just in case i need to manipulate lower case and stuff
  String userDisease;
  final String userDiseaseID;

  //set to firebase id, so I can access the db properly, and get the users input
  DiseaseInfoScreen(
      {this.userDiseaseID = "EO1oWhfvlkMICXgg0JqI", required this.userDisease});

  Future<Map<String, dynamic>> _getAllDiseaseInfo(String userDiseaseID) async {
    //intialize collection to FB collelction Disease Info+
    var collection =
        FirebaseFirestore.instance.collection("Disease Information");
    //get the doc from collection
    var document = await collection.doc(userDiseaseID).get();

    // document is not null
    if (document.exists) {
      // print('Document exists');
      // diseaseData is equal to data inside of document
      var diseaseData = document.data()!;
      // print('length: ${diseaseData.length}');

      // declare empty dictionary
      Map<String, dynamic> diseaseDict = {};

      // Iterate through each key in the document's data
      diseaseData.forEach((key, value) {
        // print(key);
        // print('value: $value');
        // Ensure that the value is a list before adding it to the diseases map
        // key being disease, value being the output
        diseaseDict[key] = value;
      });
      // print('diseases: $diseases');
      //return disease
      return diseaseDict;
    } else {
      //throw exception
      throw Exception("Document not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //displays the disease on the top
        title: Text(userDisease),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          //call the function
          future: _getAllDiseaseInfo(userDiseaseID),
          builder: (context, snapshot) {
            //while waiting a circle loading and returns the circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
              //returns an error
            } //make sure there is snapshot with data
            else if (snapshot.hasData) {
              // set diseases to snapshot data
              var diseases = snapshot.data!;
              // if there is an incorrect key
              if (!diseases.containsKey(userDisease)) {
                //output that there is no data available
                return Text("Data not available for $userDisease");
              }
              //the saved output for the userDisease
              var diseaseInfo = diseases[userDisease]!;
              //return output of DiseaseInfo
              return ListView.builder(
                itemCount: diseaseInfo.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(diseaseInfo[index]),
                  );
                },
              );
            }
            //hits another condition somehow return the error
            else {
              return Text("Error");
            }
          },
        ),
      ),
    );
  }
}
*/

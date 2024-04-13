import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseInfoScreen extends StatelessWidget {
  final String userDisease;
  final String userDiseaseID;

  const DiseaseInfoScreen(
      {super.key, this.userDiseaseID = "EO1oWhfvlkMICXgg0JqI", required this.userDisease});

  Future<Map<String, dynamic>> _getAllDiseaseInfo(String userDiseaseID) async {
    var collection =
        FirebaseFirestore.instance.collection("Disease Information");
    var document = await collection.doc(userDiseaseID).get();

    if (document.exists) {
      print('Document exists');
      var diseaseData = document.data()!;
      print('length: ${diseaseData.length}');

      Map<String, dynamic> diseases = {};

      // Iterate through each key-value pair in the document's data
      diseaseData.forEach((key, value) {
        // Check if the value is a list
        if (value is List) {
          // Convert each item in the list to a string and store it
          diseases[key] =
              List<String>.from(value.map((item) => item.toString()));
        } else {
          // If the value is not a list, store it as is
          diseases[key] = value;
        }
      });

      print('Diseases: $diseases');
      return diseases;
    } else {
      throw Exception("Document not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Information'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _getAllDiseaseInfo(userDiseaseID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print(snapshot.data);
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Text("No data available for any diseases");
            } else {
              var diseases = snapshot.data!;
              print('in list: ${diseases.length}');
              return ListView.builder(
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  var diseaseName = diseases.keys.elementAt(index);
                  var info = diseases[diseaseName];

                  // Check if 'info' is actually a List.
                  if (info is! List) {
                    info = ["Invalid data format for $diseaseName"];
                  }

                  return ExpansionTile(
                    title: Text(diseaseName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    children: List<Widget>.from(info.map((item) {
                      return ListTile(title: Text(item));
                    })),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

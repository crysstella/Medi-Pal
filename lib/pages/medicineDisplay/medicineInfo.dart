import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineInfoScreen extends StatelessWidget {
  final String medicineTypeID;
  final String medicineBrandID;

  const MedicineInfoScreen({super.key, 
    this.medicineTypeID = "ZUFJnzKbBHVcIoSNASDr",
    this.medicineBrandID = "ckRw2atQibDjcQb1ik7z",
  });

  //gets info from medicineType in fb collection
  Future<Map<String, dynamic>> _getAllMedicineTypes(String medicineTypeID) async {
    var collection = FirebaseFirestore.instance.collection("Medicine Types");
    var document = await collection.doc(medicineTypeID).get();

    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  //gets info from medicine Brand in fb collection
  Future<Map<String, dynamic>> _getMedicineBrandInfo(String medicineBrandID, String medicineBrand) async {
    //initialize the name of the collection and the document ID
    var collection = FirebaseFirestore.instance.collection("Medicine Brands");
    var document = await collection.doc(medicineBrandID).get();
    // returns the document data if the document ID exists within collection
    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Information'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _getAllMedicineTypes(medicineTypeID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Text("No data available for any medicines");
            } else {
              //set medicine to data
              var medicines = snapshot.data!;
              //set medicinetypes and sorts the array
              var medicineTypeArr = medicines.keys.toList()..sort();
              return ListView.builder(
                itemCount: medicineTypeArr.length,
                itemBuilder: (context, index) {
                  //get each medicine type form firebase
                  var medicineType = medicineTypeArr[index];
                  //get each value of medicine brand from medicineNamme
                  var medicineBrand = medicines[medicineType];

                  //check if medicineBrand is actually a List
                  if (medicineBrand is! List) {
                    medicineBrand = ["Invalid data format for $medicineType"];
                  }

                  return ExpansionTile(
                    title: Text(
                      medicineType,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: List<Widget>.from(medicineBrand.map((item) {
                      return FutureBuilder<Map<String, dynamic>>(
                        future: _getMedicineBrandInfo(medicineBrandID, item),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            var brandInfo = snapshot.data!;
                            var array = brandInfo[item] as List?;
                            if (array != null) {
                              //display the medicine types
                              return ListTile(
                                title: Text("•" + item, style: const TextStyle(fontSize: 16), ),
                                onTap: () {
                                  //navigate to next screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MedicineBrandScreen(
                                        brandName: item,
                                        brandInfo: array.cast<String>(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Text("No array found");
                            }
                          }
                        },
                      );
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


class MedicineBrandScreen extends StatelessWidget {
  final String brandName;
  final List<String> brandInfo;

  const MedicineBrandScreen({super.key, required this.brandName, required this.brandInfo});

  //displays the medicineBrand under medicine type
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brandName),
      ),
      body: ListView.builder(
        itemCount: brandInfo.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("•${brandInfo[index]}"),
          );
        },
      ),
    );
  }
}
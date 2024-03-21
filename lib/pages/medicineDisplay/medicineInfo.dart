import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineInfoScreen extends StatelessWidget {
  final String medicineTypeID;
  final String medicineBrandID;

  MedicineInfoScreen({
    this.medicineTypeID = "ZUFJnzKbBHVcIoSNASDr",
    this.medicineBrandID = "ckRw2atQibDjcQb1ik7z",
  });

  Future<Map<String, dynamic>> _getAllMedicineTypes(
      String medicineTypeID,
      ) async {
    var collection = FirebaseFirestore.instance.collection("Medicine Types");
    var document = await collection.doc(medicineTypeID).get();

    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  Future<Map<String, dynamic>> _getMedicineBrandInfo(
      String medicineBrandID,
      String medicineBrand,
      ) async {
    var collection = FirebaseFirestore.instance.collection("Medicine Brands");
    var document = await collection.doc(medicineBrandID).get();

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
        title: Text('Medicine Information'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _getAllMedicineTypes(medicineTypeID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Text("No data available for any medicines");
            } else {
              var medicines = snapshot.data!;
              var medicineTypes = medicines.keys.toList()..sort();
              return ListView.builder(
                itemCount: medicineTypes.length,
                itemBuilder: (context, index) {
                  var medicineName = medicineTypes[index];
                  var medicineBrand = medicines[medicineName];

                  // Check if 'medicineBrand' is actually a List
                  if (medicineBrand is! List) {
                    medicineBrand = ["Invalid data format for $medicineName"];
                  }

                  return ExpansionTile(
                    title: Text(
                      medicineName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: List<Widget>.from(medicineBrand.map((item) {
                      return FutureBuilder<Map<String, dynamic>>(
                        future: _getMedicineBrandInfo(medicineBrandID, item),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            var brandInfo = snapshot.data!;
                            var array = brandInfo[item] as List?;
                            if (array != null) {
                              return ListTile(
                                title: Text(item),
                                onTap: () {
                                  // Navigate to MedicineBrandScreen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MedicineBrandScreen(
                                        brandName: item,
                                        brandInfo: array.cast<
                                            String>(), // Cast to List<String>
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Text("No array found");
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

  MedicineBrandScreen({required this.brandName, required this.brandInfo});

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
            title: Text(brandInfo[index]),
          );
        },
      ),
    );
  }
}
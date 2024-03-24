import 'package:flutter/material.dart';
import 'package:medipal/firebase/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineInfoScreen extends StatelessWidget {
  DataService medService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Information'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: medService.getAllMedicineTypes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Text("No data available for any medicines");
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
                        future: medService.getMedicineBrandInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
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
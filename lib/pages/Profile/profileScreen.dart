
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  Future<DocumentSnapshot<Map<String, dynamic>>> _displayProfile() async {
    var collection = FirebaseFirestore.instance.collection("users");
    var document = await collection.doc("a@gmail.com").get();
    return document;
  }

  // Function to calculate daily water intake based on body weight
double calculateWater(String lbs) {
  double weight = double.parse(lbs);
  return weight * (2/3); 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.blue.shade600],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: _displayProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Extract data from snapshot
                  var data = snapshot.data!.data();
                  String birthday = data?['birthday'] ?? '';
                  String disease = data?['disease'] ?? '';
                  String height = data?['height'] ?? '';
                  String weight = data?['weight'] ?? '';

                  double waterIntake = calculateWater(weight);

                  // Display the data in a styled card layout
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile Information',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Birthday: $birthday',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Disease: $disease',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Height: $height',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Weight: $weight',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 10),
                          Text(
                            'Daily Water Consumption: ${waterIntake.toStringAsFixed(2)} ounces',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  final String? email;
  const ProfileScreen({super.key, required this.email});

  Future<DocumentSnapshot<Map<String, dynamic>>> _displayProfile() async {
    var collection = FirebaseFirestore.instance.collection("users");
    var document = await collection.doc(email).get();
    return document;
  }

  // Function to calculate daily water intake based on body weight
double calculateWater(String lbs) {
  double weight = double.parse(lbs);

  return weight * (2/3); 
}

int heightStringToInches(height) {
  List<String> parts = height.split("'");
  int feet = int.parse(parts[0]);
  int inches = int.parse(parts[1].replaceAll("'", ""));
  return (feet * 12 + inches);
}

int calculateAge(String birthdayString) {
  //convert the birthdayString to a valid format (assuming MM-DD-YYYY)
  List<String> parts = birthdayString.split("-");
  String formattedBirthday = "${parts[2]}-${parts[0]}-${parts[1]}";
  //parse the birthday string
  DateTime birthday = DateTime.parse(formattedBirthday);
  //get the current date
  DateTime currentDate = DateTime.now();
  //calculate the difference in years
  int age = currentDate.year - birthday.year;
  // check if the birthday for this year has occurred
  if (currentDate.month < birthday.month ||
      (currentDate.month == birthday.month && currentDate.day < birthday.day)) {
    age--;
  }
  return age;
}

  // function to calculate maintinence calories
double calculateMaintinence(lbs, birthday, height) {
  //get values for weight, height, and years
  double weight = double.parse(lbs);
  double heightConverted = heightStringToInches(height).toDouble();
  double years = calculateAge(birthday).toDouble();
  //plug into formula and get the maintinences
  double maintinence = (10 * weight  + 6.25 * (heightConverted * 2.54) - 5 * years - 161);
  return maintinence; 
}

Future<void> _saveMaintinence(maintinence) async {
  //save favorite foods to SharedPreferences
    double calories = maintinence;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('calories', calories);
}

// function to save water goal
Future<void> _saveWater(double waterGoal) async {
  double waterAmount = waterGoal;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('waterGoal', waterAmount);
}

   @override
  Widget build(BuildContext context) {
    return Container(
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
                  //extract data from snapshot
                  var data = snapshot.data!.data();
                  String birthday = data?['birthday'] ?? '';
                  String disease = data?['userDisease'] ?? '';
                  String height = data?['height'] ?? '';
                  String weight = data?['weight'] .toString()?? '';
                  //gets the maintinence and calorie goal
                  double waterIntake = calculateWater(weight);
                  double maintinence = calculateMaintinence(weight, birthday, height);
                  //saves waterGoal and calorieGoal locally
                  _saveMaintinence(maintinence);
                  _saveWater(waterIntake);
                  //display the data in a styled card layout
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
                          const SizedBox(height: 10),
                          Text(
                            'Daily Water Consumption: ${waterIntake.toStringAsFixed(2)} ounces',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Maintinence Calories: ${maintinence.toStringAsFixed(2)} calories',
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
    );
  }
}
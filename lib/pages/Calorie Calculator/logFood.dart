import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../sharedPref.dart';

class LogFood extends StatefulWidget {
  //initialize id for databases, and email/userEmail to get stored Email
  final String foodID;
  final String calorieID;
  late Future<String?> email;
  String? userEmail;

  LogFood({
    Key? key,
    this.userEmail,
    this.foodID = "2O1FKL6tcyXKC8v3GPIS", // Food Database document ID
    this.calorieID = "8nJVf1Jai1UD3xdam32o", // Calories Database document ID
  }) : super(key: key);

  @override
  State<LogFood> createState() => _LogFoodState();
}

class _LogFoodState extends State<LogFood> {
  late String _userDisease;
  String? _selectedFood;
  TextEditingController servingSizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEmailAndDisease();
  }

  Future<void> _fetchEmailAndDisease() async {
    try {
      final email = await getEmail();
      setState(() {
        widget.userEmail = email;
      });
      final disease = await _getUserDisease(widget.userEmail);
      setState(() {
        _userDisease = disease;
      });
    } catch (error) {
      print("Failed to fetch email and disease: $error");
    }
  }

  Future<void> _saveLogFoodToFirestore(Map<String, dynamic> loggedFood) async {
    try {
      var collection = FirebaseFirestore.instance.collection("users");
      if (widget.userEmail != null) {
        var docRef = collection.doc(widget.userEmail);
        var docSnapshot = await docRef.get();
        
        if (docSnapshot.exists) {
          // Get a unique ID for the new food entry
          String foodId = docRef.collection("loggedFoods").doc().id;

          // Add the foodId to the logged food data
          loggedFood['id'] = foodId;

          // Get the current logged foods array
          List<dynamic> currentLoggedFoods = docSnapshot.data()?['loggedFoods'] ?? [];
          // Append the new logged food to the array
          currentLoggedFoods.add(loggedFood);
          // Update the array in Firestore
          await docRef.update({
            "loggedFoods": currentLoggedFoods,
          });
        } else {
          await docRef.set({
            "userEmail": widget.userEmail,
            "loggedFoods": [loggedFood],
          });
        }
      } else {
        throw Exception("User email is null");
      }
    } catch (error) {
      print("Failed to save logged foods: $error");
    }
  }

  //get the food info from fooddb
  Future<Map<String, dynamic>> _getFoodInfo(String foodID) async {
    var collection = FirebaseFirestore.instance.collection("Food Database");
    var document = await collection.doc(foodID).get();
    if (document.exists) {
      //make array of food db based on disease
      Map<String, dynamic> foodData = {};
      (document.data() as Map<String, dynamic>).forEach((key, value) {
        foodData[key.toLowerCase()] = value;
      });
      return foodData;
    } else {
      throw Exception("Document not found");
    }
  }
  //calorie info from calorie db
  Future<Map<String, dynamic>> _getCalorieInfo(String calorieID) async {
    var collection = FirebaseFirestore.instance.collection("Calories Database");
    var document = await collection.doc(calorieID).get();
    //return the info
    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  //get userDisease that is saved to userEmail
  Future<String> _getUserDisease(String? userEmail) async {
    if (userEmail == null) {
      throw Exception("User email is null");
    }
    var collection = FirebaseFirestore.instance.collection("users");
    var document = await collection.doc(userEmail).get();

    if (document.exists) {
      String? userDisease = (document.data()?['userDisease'] as String?)?.toLowerCase();
      return userDisease ?? '';
    } else {
      throw Exception("User data not found for $userEmail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Food"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getFoodInfo(widget.foodID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var foodData = snapshot.data!;
            if (!foodData.containsKey(_userDisease)) {
              return Center(
                child: Text("Data not available for $_userDisease"),
              );
            }

            var foodInfo = foodData[_userDisease] as List<dynamic>;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add what you have eaten through the scroll down menu",
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: _selectedFood,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFood = newValue;
                      });
                    },
                    items: foodInfo.map<DropdownMenuItem<String>>((dynamic food) {
                      return DropdownMenuItem<String>(
                        value: food.toString(),
                        child: Text(food.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: servingSizeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter serving size in ounces",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _calculateCalories(); 
                    },
                    child: Text("Log Food"),
                  ),
                ],
              ),
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

  Future<void> _calculateCalories() async {
    if (_selectedFood == null) {
      return;
    }
    double servingSize = double.tryParse(servingSizeController.text) ?? 0;
    if (servingSize <= 0) {
      return;
    }
    try {
      //gets calories from db
      var calorieData = await _getCalorieInfo(widget.calorieID);
      //initialized to to the logged food element
      var caloriesForSelectedFood = calorieData[_selectedFood!.toLowerCase()];
      if (caloriesForSelectedFood != null) {
        //calculate the total calories of the food based on serving size
        double totalCalories = servingSize * caloriesForSelectedFood;
        print("Total calories: $totalCalories");
        //prepare it to be saved
        Map<String, dynamic> loggedFood = {
          "food": _selectedFood,
          "totalCalories": totalCalories,
        };
        await _saveLogFoodToFirestore(loggedFood);

      } else {
        print("Calories data not available for $_selectedFood");
      }
    } catch (error) {
      print("Failed to retrieve calorie information: $error");
    }
  }
}
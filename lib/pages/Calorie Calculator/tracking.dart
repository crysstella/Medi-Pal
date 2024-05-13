import 'package:flutter/material.dart';
import 'logFood.dart';
import '../../sharedPref.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  //stores the logged food elements
  late List<Map<String, dynamic>> _loggedFoods = []; 
  //initialize the total calories and calorie goal
  double _totalCalories = 0;
  double? _calorieGoal = 0; 
  //allows us to update app from fb whenver it's need
  late StreamSubscription<DocumentSnapshot> _sub;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    //cancel the sub to avoid memory leaks
    _sub.cancel(); 
    super.dispose();
  }

  //initialize data and set up Firestore sub
  Future<void> _initializeData() async {
    //fetch user's maintenance calories
    await _fetchMaintenanceCalories(); 
    _subToFoodUpdates();
  }

  //gets logged food from firebase and totalCalories from the function calcCaloriesEaten
  Future<void> _fetchLoggedFoodsFromFirestore(DocumentSnapshot snapshot) async {
    try {
      String? email = await getEmail();
      if (email != null) {
        final loggedFoods = await getLoggedFoodsFromSnapshot(snapshot);
        setState(() {
          _loggedFoods = loggedFoods;
          _totalCalories = _calculateCaloriesEaten(_loggedFoods);
        });
      }
    } catch (error) {
      print("Failed to fetch logged foods from Firestore: $error");
    }
  }

  // Fetch user's maintenance calories
  Future<void> _fetchMaintenanceCalories() async {
    try {
      double? maintenanceCalories = await getCalories(); // Get maintenance calories
      setState(() {
        _calorieGoal = maintenanceCalories; // Set the calorie goal
      });
    } catch (error) {
      print("Failed to fetch maintenance calories: $error");
    }
  }

  //calculate total calories eaten
  double _calculateCaloriesEaten(List<Map<String, dynamic>> loggedFoods) {
    double totalCalories = 0;
    //gets all the ellements from the array then gets the totalCalories of that element
    loggedFoods.forEach((food) {
      totalCalories += (food['totalCalories'] ?? 0);
    });
    return totalCalories;
  }

  //updates app when changes in logged foods
  void _subToFoodUpdates() async {
    String? email = await getEmail();
    if (email != null) {
      _sub = FirebaseFirestore.instance.collection('users').doc(email).snapshots().listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          _fetchLoggedFoodsFromFirestore(snapshot);
        }
      });
    }
  }

  //convert Firestore snapshot to logged foods list
  List<Map<String, dynamic>> getLoggedFoodsFromSnapshot(DocumentSnapshot snapshot) {
    List<Map<String, dynamic>> loggedFoods = [];
    Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
    if (userData != null) {
      List<dynamic>? loggedFoodsArray = userData['loggedFoods'];
      if (loggedFoodsArray != null) {
        for (var foodEntry in loggedFoodsArray) {
          if (foodEntry is Map<String, dynamic>) {
            loggedFoods.add(foodEntry);
          }
        }
      }
    }
    return loggedFoods;
  }

  //display logged foods to user
  Widget _buildLoggedFoods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Logged Foods',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (_loggedFoods.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _loggedFoods.map((food) {
              //extracts information from the food's info in fb
              String foodName = food['food'] ?? '';
              double totalCalories = food['totalCalories'] ?? 0;
              String id = food['id'] ?? ''; 
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          //displays the logged food element name and it's calories
                          '$foodName - $totalCalories Calories',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //pass id to delete that food
                          _deleteLoggedFood(id);
                          print(id);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
      ],
    );
  }

//deletes loggedfood element in fb based off id
Future<void> _deleteLoggedFood(String id) async {
  String? email = await getEmail();
  if (email != null) {
    try {
      //remove the food entry from the fb doc where there id is
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'loggedFoods': FieldValue.arrayRemove(
          _loggedFoods.where((food) => food['id'] == id).toList(),
        ),
      });

      //remove the food entry from the app/local state based on id as well
      setState(() {
        _loggedFoods.removeWhere((food) => food['id'] == id);
        //recalculate the totalCalories after the user deletes that food
        _totalCalories = _calculateCaloriesEaten(_loggedFoods);
      });
    } catch (error) {
      print("Failed to delete logged food: $error");
    }
  }
}

  
  //builds the add food button
  Widget _buildAddFoodButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigates to logFood when presses
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogFood()),
        );
      },
      child: Text(
        'Add Food',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //display a message if calorie goal is exceeded which is when totalCalories is greater
    Widget exceededCalorieGoalMessage = _calorieGoal != null && _totalCalories > _calorieGoal!
        ? Text(
            'You have exceeded your calorie goal for today!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          )
        : SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Calories Eaten: $_totalCalories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            //display message if calorie goal is exceeded
            exceededCalorieGoalMessage, 
            //builds the loggedFood and add button for the user to view
            SizedBox(height: 20),
            _buildLoggedFoods(),
            SizedBox(height: 20),
            _buildAddFoodButton(context),
          ],
        ),
      ),
    );
  }
}
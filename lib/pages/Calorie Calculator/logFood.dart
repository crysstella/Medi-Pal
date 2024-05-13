import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medipal/firebase/services.dart';
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
  DataService firebaseService = DataService();


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
      final disease = await firebaseService.getUserDisease(widget.userEmail);

      setState(() {
        _userDisease = disease;
      });
    } catch (error) {
      print("Failed to fetch email and disease: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Log"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: firebaseService.getFoodInfo(widget.foodID),
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
                    "Scroll down the menu to add what you have eaten.",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                   SizedBox(height: 40),

                  Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4)),
                  child: 
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
                  
                  
                  ),


                  SizedBox(height: 20),
                  TextFormField(
                    controller: servingSizeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter serving size in ounces",
                    ),
                  ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {
                      _calculateCalories(); 
                    },
                    style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary), 
                 ),
                    child: Text("LOG FOOD", style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
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
      var calorieData = await firebaseService.getCalorieInfo(widget.calorieID);
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
        await firebaseService.saveLogFoodToFirestore(loggedFood, widget.userEmail!);

      } else {
        print("Calories data not available for $_selectedFood");
      }
    } catch (error) {
      print("Failed to retrieve calorie information: $error");
    }
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DietScreen extends StatefulWidget {
  final String foodID;
  //initalize food db id
  DietScreen({Key? key, this.foodID = "2O1FKL6tcyXKC8v3GPIS"}) : super(key: key);

  @override
  _DietScreenState createState() => _DietScreenState();
}

//initialize everything for diseaseArr, diff diets and key words for the diet
class _DietScreenState extends State<DietScreen> {
  final List<String> diseaseArr = ['Ankylosing Spondylitis', "Diabetes", "Kidney Disease"];
  final List<String> dietArr = ['Vegan', 'Pescatarian'];
  final List<String> veganKeywords = ["tofu", "tempeh", "seitan", "beans", "legumes", "lentils", "chickpeas", "vegetables", "fruits", "nuts", "seeds", "quinoa", "whole grains", "plant-based milk", "plant-based yogurt", "plant-based cheese", "nutritional yeast", "vegetable broth", "coconut oil", "olive oil", "avocado", "leafy greens", "soy products"];
  final List<String> pescKeywords = ["fish", "salmon", "tuna", "sardines", "trout", "mackerel", "haddock", "cod", "shrimp", "prawns", "scallops", "lobster", "crab", "mussels", "clams", "oysters", "octopus", "squid", "anchovies"];

  String? selectedDisease;
  String? selectedDiet;
  String instructions = 'Choose a disease and the diet you would like to pursue to receive an array of food associated with that combination.';

  //gets info from food db
  Future<Map<String, dynamic>> _getAllFoodInfo(String foodID) async {
    var collection = FirebaseFirestore.instance.collection("Food Database");
    var document = await collection.doc(foodID).get();
    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            instructions,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          //allows for input of a disease
          Container(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
             decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1)),
             child: 
          DropdownButton<String>(
            value: selectedDisease,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedDisease = newValue;
                });
              }
            },
            //creates dropdown menu of diseases
            items: diseaseArr.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ),


          SizedBox(height: 20),
          //allows for input of the diet

          Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
                  child: 
          DropdownButton<String>(
            value: selectedDiet,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedDiet = newValue;
                });
              }
            },
            
            //creates dropdown menu of diets
            items: dietArr.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              height: 300,
              child: FutureBuilder<Map<String, dynamic>>(
                future: _getAllFoodInfo(widget.foodID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    //get the snapshot of the data
                  } else if (snapshot.hasData) {
                    var foodData = snapshot.data!;
                    if (!foodData.containsKey(selectedDisease)) {
                      return Center(
                        child: Text(""),
                      );
                    }
                    //get foodarr based off the disease from fb
                    var foodInfo = foodData[selectedDisease] as List<dynamic>;
                    //filter food based off keywords and return a new arr based off that
                    var filteredFood = foodInfo.where((food) {
                      if (selectedDiet == 'Vegan') {
                        return veganKeywords.any((keyword) => food.toLowerCase().contains(keyword));
                      } else if (selectedDiet == 'Pescatarian') {
                        return pescKeywords.any((keyword) => food.toLowerCase().contains(keyword));
                      }
                      return false;
                    }).toList();
                    //if there is no key words return this
                    if (filteredFood.isEmpty) {
                      return Center(
                        child: Text("No suitable food found for $selectedDiet diet"),
                      );
                    }
                    //displays filtered food to the user
                    return ListView.builder(
                      itemCount: filteredFood.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('• ' + filteredFood[index]),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("Error loading data"),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
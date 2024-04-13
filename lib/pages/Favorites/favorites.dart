import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite extends StatefulWidget {
  // Initialize the strings for userDisease and foodId to call the database
  final String userDisease;
  final String foodID;

  const Favorite({
    super.key,
    //set the disease to diabetes for now
    this.userDisease = "Diabetes",
    // Set the default document id
    this.foodID = "2O1FKL6tcyXKC8v3GPIS",
  });

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  //create empty array
  List<String> favoriteFoods = [];
  //called in dropdown Menu
  String? _selectedFood;

  //get document and information from Firebase
  Future<Map<String, dynamic>> _getAllFoodInfo(String foodID) async {
    var collection = FirebaseFirestore.instance.collection("Food Database");
    var document = await collection.doc(foodID).get();

    // if document is found and not null
    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  //save array to firestore favorite colllection
  Future<void> _saveFavoriteFoodsToFirestore(List<String> foods) async {
    try {
      var collection = FirebaseFirestore.instance.collection("favorite");
      //adds the food to where that disease is
      var querySnapshot = await collection
          .where("userDisease", isEqualTo: widget.userDisease)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // gets the first document in the list
        var doc = querySnapshot.docs.first;
        // updates the array with food in the document
        await doc.reference.update({"favoriteFoods": foods});
      } else {
        await collection.add({
          "userDisease": widget.userDisease,
          "favoriteFoods": foods,
          "timestamp": DateTime.now(),
        });
      }
    } catch (error) {
      print("Failed to save favorite foods: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      //collects information from food database
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getAllFoodInfo(widget.foodID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var foodData = snapshot.data!;
            //find if the key of userDisease is in the food information database
            if (!foodData.containsKey(widget.userDisease)) {
              return Center(
                child: Text("Data not available for ${widget.userDisease}"),
              );
            }

            //gets the array matching the diseases int the food information db
            var foodInfo = foodData[widget.userDisease] as List<dynamic>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Added for alignment
              children: [
                // text added for instruction
                const Text(
                  "Please add your favorite food by using the dropdown menu below: ",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black),
                ),
                //button to click on the dropdown menu
                DropdownButton<String>(
                  value: _selectedFood,
                  //when clicked adds food to selectedFood
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFood = newValue;
                    });
                    if (_selectedFood != null && !favoriteFoods.contains(_selectedFood!)) {
                      setState(() {
                        //adds food to array
                        favoriteFoods.add(_selectedFood!);
                        //call the save function to add into database
                        _saveFavoriteFoodsToFirestore(favoriteFoods);
                      });
                    }
                  },
                  //create dropdown menu from foodInfo
                  items: foodInfo.map<DropdownMenuItem<String>>((dynamic food) {
                    return DropdownMenuItem<String>(
                      //holds currently selected food
                      value: food.toString(),
                      // display food text for dropdown
                      child: Text("• $food"), // Added bullet point
                    );
                    //convert the map to an array
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your Favorite Foods:",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteFoods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10), // Adjust padding as needed
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 238, 238, 238), // Customize the color as needed
                          ),
                          child: Text(
                            favoriteFoods[index],
                            style: const TextStyle(fontSize: 16), // Adjust font size as needed
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
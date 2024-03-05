import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite extends StatefulWidget {
  final String userDisease;
  final String foodID;

  // const Favorite({
  //   Key? key,
  //   required this.userDisease,
  //   this.foodID = "2O1FKL6tcyXKC8v3GPIS",
  // }) : super(key: key);

  const Favorite({
    Key? key,
    this.userDisease = "Diabetes",
    this.foodID = "2O1FKL6tcyXKC8v3GPIS",
  }) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<String> favoriteFoods = [];
  String? _selectedFood;

  Future<Map<String, dynamic>> _getAllFoodInfo(String foodID) async {
    var collection = FirebaseFirestore.instance.collection("Food Database");
    var document = await collection.doc(foodID).get();

    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  Future<void> _saveFavoriteFoodsToFirestore(List<String> foods) async {
    try {
      var collection = FirebaseFirestore.instance.collection("favorite");
      var querySnapshot = await collection
          //adds the food to where that disease is
          .where("userDisease", isEqualTo: widget.userDisease)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
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
        title: Text("Favorites"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getAllFoodInfo(widget.foodID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var foodData = snapshot.data!;
            if (!foodData.containsKey(widget.userDisease)) {
              return Center(
                child: Text("Data not available for ${widget.userDisease}"),
              );
            }

            var foodInfo = foodData[widget.userDisease] as List<dynamic>;

            return Column(
              children: [
                DropdownButton<String>(
                  value: _selectedFood,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFood = newValue;
                    });
                    if (_selectedFood != null &&
                        !favoriteFoods.contains(_selectedFood!)) {
                      setState(() {
                        favoriteFoods.add(_selectedFood!);
                        _saveFavoriteFoodsToFirestore(favoriteFoods);
                      });
                    }
                  },
                  items: foodInfo.map<DropdownMenuItem<String>>((dynamic food) {
                    return DropdownMenuItem<String>(
                      value: food.toString(),
                      child: Text(food.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text("Favorite Foods:"),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteFoods.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(favoriteFoods[index]),
                      );
                    },
                  ),
                ),
              ],
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
}

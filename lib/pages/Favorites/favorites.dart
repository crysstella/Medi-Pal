import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  final String foodID;
  late Future<String?> email;
  String? userEmail;

  Favorite({
    Key? key,
    this.userEmail,
    this.foodID = "2O1FKL6tcyXKC8v3GPIS",
  }) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late String _userDisease;
  List<String> favoriteFoods = [];
  String? _selectedFood;

  @override
  void initState() {
    super.initState();
    _fetchEmailAndDisease();
    _loadFavoriteFoods();
  }

  //get users email and disease from sharedPref functions
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

  //displays favorite foods saved in local
  Future<void> _loadFavoriteFoods() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      //get an array of the favorite foods from local memory
      final savedFoods = prefs.getStringList('favoriteFoods');
      if (savedFoods != null) {
        setState(() {
          //initialized favorite to saved foods
          favoriteFoods = savedFoods;
        });
      }
    } catch (error) {
      print("Failed to load favorite foods: $error");
    }
  }

  Future<Map<String, dynamic>> _getAllFoodInfo(String foodID) async {
  var collection = FirebaseFirestore.instance.collection("Food Database");
  var document = await collection.doc(foodID).get();

  if (document.exists) {
    // convert keys to lowercase and store in a new map
    Map<String, dynamic> foodData = {};
    (document.data() as Map<String, dynamic>).forEach((key, value) {
      foodData[key.toLowerCase()] = value;
    });
    return foodData;
  } else {
    throw Exception("Document not found");
  }
}

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

 Future<void> _saveFavoriteFoodsToFirestore(List<String> foods) async {
  try {
    var collection = FirebaseFirestore.instance.collection("users");
    //check if userEmail is available
    if (widget.userEmail != null) {
      //use userEmail as the document ID
      var docRef = collection.doc(widget.userEmail);
      //fetch the document snapshot
      var docSnapshot = await docRef.get();
      
      if (docSnapshot.exists) {
        //if document exists, update favorite foods
        await docRef.update({"favoriteFoods": foods});
      } else {
        //if document doesn't exist, create it with userEmail as document ID
        await docRef.set({
          "userEmail": widget.userEmail,
          "favoriteFoods": foods,
          "timestamp": DateTime.now(),
        });
      }
    } else {
      throw Exception("User email is null");
    }

    //save favorite foods to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteFoods', foods);
  } catch (error) {
    print("Failed to save favorite foods: $error");
  }
}

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
            if (!foodData.containsKey(_userDisease)) {
              return Center(
                child: Text("Data not available for $_userDisease"),
              );
            }
            
            var foodInfo = foodData[_userDisease] as List<dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please add your favorite food by using the dropdown menu below: ",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black),
                ),
                DropdownButton<String>(
                  value: _selectedFood,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFood = newValue;
                    });
                    if (_selectedFood != null) {
                      if (favoriteFoods.contains(_selectedFood!)) {
                        //if the selected food is already in favoriteFoods, remove it
                        setState(() {
                          favoriteFoods.remove(_selectedFood!);
                        });
                      } else {
                        //otherwise, add it to favoriteFoods
                        setState(() {
                          favoriteFoods.add(_selectedFood!);
                        });
                      }
                      //save the updated favoriteFoods list
                      _saveFavoriteFoodsToFirestore(favoriteFoods);
                    }
                  },
                  items: foodInfo.map<DropdownMenuItem<String>>((dynamic food) {
                    return DropdownMenuItem<String>(
                      value: food.toString(),
                      child: Text("• " + food.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  "Your Favorite Foods:",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteFoods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 238, 238, 238),
                          ),
                          child: Text(
                            favoriteFoods[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
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
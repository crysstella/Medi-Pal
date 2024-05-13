import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseaseAdvice {
  List<String> recommendations;
  List<String> avoidances;

  DiseaseAdvice({required this.recommendations, required this.avoidances});
}

class DataService {
  //Firebase instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Medicine information
  final medTypeCollection = 'Medicine Types';
  final medBrandCollection = 'Medicine Brands';
  final diseaseCollection = 'Disease Information';
  final diseaseID = 'EO1oWhfvlkMICXgg0JqI';
  final medicineTypeID = 'ZUFJnzKbBHVcIoSNASDr';
  final medicineBrandID = 'ckRw2atQibDjcQb1ik7z';

  // Food database
  // Set the default document id
  final foodCollection = 'Food Database';
  final foodID = '2O1FKL6tcyXKC8v3GPIS';

  // userDisease get

  // Get diseases list in Food Database
  Future<List<String>> getDiseasesInFoodDatabase() async {
    var collection = firestore.collection(foodCollection);
    var document = await collection.doc(foodID).get();

    if (document.exists) {
      Map<String, dynamic> data = document.data()!;
      if (data.isNotEmpty) {
        return List<String>.from(data.keys);
      } else {
        throw Exception("Document not found");
      }
    } else {
      throw Exception("Document not found");
    }
  }

// Get foods by disease name
  Future<List<String>> getFoodsByDisease(String disease) async {
    debugPrint('DISEASE FOOD');
    var collection = firestore.collection(foodCollection);
    var document = await collection.doc(foodID).get();

    if (document.exists) {
      debugPrint('DOCUMENT EXISTS');
      Map<String, dynamic> data = document.data()!;
      if (data.containsKey(disease)) {
        debugPrint('DISEASE EXISTS: ${disease}');
        debugPrint('FOODS LIST EXISTS!!!!!!!');
        debugPrint(List<String>.from(data[disease]).toString());
        return List<String>.from(data[disease]);
      } else {
        throw Exception("Disease key not found in the document");
      }
    } else {
      throw Exception("Document not found");
    }
  }

  /// Read all medicine type
  Future<Map<String, dynamic>> getAllMedicineTypes() async {
    var collection = firestore.collection(medTypeCollection);
    var document = await collection.doc(medicineTypeID).get();

    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  /// Read medicine brand
  Future<Map<String, dynamic>> getMedicineBrandInfo() async {
    var collection = firestore.collection(medBrandCollection);
    var document = await collection.doc(medicineBrandID).get();

    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  // Get all medicine names.
  Future<List<String>> getMedicineNames() async {
    var collection = firestore.collection(medTypeCollection);
    var document = await collection.doc(medicineTypeID).get();

    if (document.exists) {
      // Extract data from medicine type collection
      Map<String, dynamic> data = document.data()!;
      // A list to store medicine names in each type
      List<String> medicineNames = [];

      // Iterate over the documents and collect the medicine names
      data.forEach((key, value) {
        if (value is List) {
          medicineNames.addAll(List<String>.from(value));
        }
      });

      return medicineNames;
    } else {
      throw Exception("Document not found");
    }
  }

  // Get disease info
  Future<Map<String, dynamic>> getAllDiseaseInfo() async {
    //get the information
    var collection = firestore.collection(diseaseCollection);
    var document = await collection.doc(diseaseID).get();

    if (document.exists) {
      //return map of arrays
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  // Get disease info by name
  Future<DiseaseAdvice> getDiseaseAdvice(String diseaseName) async {
    var collection = firestore.collection(diseaseCollection);
    var document = await collection.doc(diseaseID).get();

    if (document.exists) {
      List<dynamic> diseases = document.get(diseaseName) as List<dynamic>;
      debugPrint('IN SERVICE DISEASE GET = $diseases');
      List<String> foodsRecommended = [];
      List<String> foodsAvoided = [];

      // Iterate over each element in the disease list
      for (var disease in diseases) {
        // Find recommend foods for a disease
        if (disease.containsKey('Foods Recommended')) {
          List<dynamic> recommend = disease['Foods Recommended'];
          for (var item in recommend) {
            if (item != null) {
              foodsRecommended.add(item);
            }
          }
        }
        // Find avoid foods for a disease
        if (disease.containsKey('Foods to Avoid')) {
          List<dynamic> avoids = disease['Foods to Avoid'];
          for (var item in avoids) {
            if (item != null) {
              foodsAvoided.add(item);
            }
          }
        }

        debugPrint('avoid: $foodsAvoided');
        debugPrint('recommend: $foodsRecommended');
      }
      return DiseaseAdvice(
          recommendations: foodsRecommended, avoidances: foodsAvoided);
    } else {
      throw Exception("debugPrint Document not found");
    }
  }

  // Get disease names list
  Future<List<String>> getDiseaseName() async {
    var collection = firestore.collection(diseaseCollection);
    var document = await collection.doc(diseaseID).get();
    List<String> diseaseName = [];
    if (document.exists) {
      // Extract data from medicine type collection
      Map<String, dynamic> data = document.data()!;
      // Iterate over the documents and collect the medicine names
      data.forEach((key, value) {
        diseaseName.add(key);
      });
    }
    debugPrint('Disease name: $diseaseName');
    return diseaseName;
  }

  Future<void> saveLogFoodToFirestore(
      Map<String, dynamic> loggedFood, String email) async {
    try {
      var collection = firestore.collection("users");
      if (email != null) {
        var docRef = collection.doc(email);
        var docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          // Get a unique ID for the new food entry
          String foodId = docRef.collection("loggedFoods").doc().id;

          // Add the foodId to the logged food data
          loggedFood['id'] = foodId;

          // Get the current logged foods array
          List<dynamic> currentLoggedFoods =
              docSnapshot.data()?['loggedFoods'] ?? [];
          // Append the new logged food to the array
          currentLoggedFoods.add(loggedFood);
          // Update the array in Firestore
          await docRef.update({
            "loggedFoods": currentLoggedFoods,
          });
        } else {
          await docRef.set({
            "userEmail": email,
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
  Future<Map<String, dynamic>> getFoodInfo(String foodID) async {
    var collection = firestore.collection("Food Database");
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
  Future<Map<String, dynamic>> getCalorieInfo(String calorieID) async {
    var collection = firestore.collection("Calories Database");
    var document = await collection.doc(calorieID).get();
    //return the info
    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      throw Exception("Document not found");
    }
  }

  //get userDisease that is saved to userEmail
  Future<String> getUserDisease(String? userEmail) async {
    if (userEmail == null) {
      throw Exception("User email is null");
    }
    var collection = firestore.collection("users");
    var document = await collection.doc(userEmail).get();

    if (document.exists) {
      String? userDisease =
          (document.data()?['userDisease'] as String?)?.toLowerCase();
      return userDisease ?? '';
    } else {
      throw Exception("User data not found for $userEmail");
    }
  }


}

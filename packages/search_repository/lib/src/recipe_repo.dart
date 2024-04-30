// import 'dart:convert';
// import 'package:search_repository/src/search_repo.dart';
// import 'package:search_repository/src/models/search_recipe_model.dart';
// import 'package:search_repository/src/api/api_key.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class SearchRecipeRepository implements SearchRepository{

//   //final http.Client _httpClient;
//   final String apiUrl = "https://api.edamam.com/api/recipes/v2";
//   //final String apiKey = ApiKey.apiKey; 
//   final String apiKey = apiKey;

//   SearchRecipeRepository(this.apiKey);

//   @override
//   Future<List<dynamic>> searchRecipes(String query) async {
//     final response = await http.get(
//       Uri.parse('$apiUrl?type=public&q=$query&app_id=b0eefc7c&app_key=$apiKey'),
//     );
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       return data['hits'];
//     } else {
//       throw Exception('Failed to load recipes');
//     }
//   }
//   // @override
//   // void dispose() {
//   //   _httpClient.close();
//   // }
// }

// class SearchRecipeModel {
//   String title;
//   String image;
//   int kcal;
//   int servings;
//   int cookingTime;
//   String url;
//   List<bool> takedingredients;
//   List<String> ingredients;

//   SearchRecipeModel({
//     required this.title,
//     required this.image,
//     required this.kcal,
//     required this.servings,
//     required this.cookingTime,
//     required this.ingredients,
//     required this.url,
//   }) : takedingredients = List<bool>.filled(ingredients.length, false);

//   // Method to convert a Map to a RecipeModel
//   factory SearchRecipeModel.fromMap(Map<String, dynamic> map) {
//     return SearchRecipeModel(
//       title: map['recipe']['label'],
//       image: map['recipe']['image'],
//       kcal: map['recipe']['calories'].toInt(),
//       servings: map['recipe']['yield'].toInt(),
//       cookingTime: map['recipe']['totalTime'].toInt(),
//       url: map['recipe']['url'],
//       ingredients: List<String>.from(
//           map['recipe']['ingredients'].map((ingredient) => ingredient['text'])),
//     );
//   }
// }

// // class SearchRecipeRepository implements SearchRepository {
// //   // If you're making multiple requests to the same server,
// //   // you can keep open a persistent connection by using a Client rather than making one-off requests.
// //   // If you do this, make sure to close the client when you're done:
// //   final http.Client _httpClient;
// //   final apiUrl = "https://api.edamam.com/api/recipes/v2";
// //   final key = ApiKey.apiKey; 

// //   SearchRecipeRepository({http.Client? httpClient})
// //       : _httpClient = httpClient ?? http.Client();
// //   // if no parameter is passed in then instantiate new http client

// //   @override
// //   Future<List<Result>> searchRecipes({String? query}) async {
// //     final response = await _httpClient.get(Uri.parse(apiUrl));

// //     if (response.statusCode == 200) {
// //       return foodModelFromJson(response.body).results;
// //     } else {
// //       throw Exception('Failed to load recipes.');
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _httpClient.close();
// //   }
// // }
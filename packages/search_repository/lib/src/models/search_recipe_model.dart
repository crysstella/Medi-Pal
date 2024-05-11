// // To parse this JSON data, do
// //
// //     final recipeModel = recipeModelFromJson(jsonString);

// import 'dart:convert';
// import 'package:equatable/equatable.dart';

// SearchRecipeModel foodModelFromJson(String str) => SearchRecipeModel.fromJson(json.decode(str));

// String foodModelToJson(SearchRecipeModel data) => json.encode(data.toJson());

// class SearchRecipeModel extends Equatable{

//   final List<Result> results;
//   final String title;
//   final String? image;
//   final int kcal;
//   final int? servings;
//   final int? cookingTime;
//   final String? url;
//   //final List<bool>? takedingredients;
//   final List<String> ingredients;

//   const SearchRecipeModel({
//     required this.results,
//     required this.title,
//     this.image,
//     required this.kcal,
//     this.servings,
//     this.cookingTime,
//     this.url,
//     required this.ingredients,
//   });

//   factory SearchRecipeModel.fromJson(Map<String, dynamic> json) => SearchRecipeModel(
//     title: json["title"],
//     image: json['image'],
//     kcal: json['calories'].toInt(),
//     servings: json['yield'].toInt(),
//     cookingTime: json['totalTime'].toInt(),
//     url: json['url'],
//     ingredients: List<String>.from(json['ingredients'].map((ingredient) => ingredient['text'])),
//     results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "title": title, 
//     "image": image,
//     "kcal": kcal,
//     "servings": servings,
//     "cookingTime": cookingTime,
//     "url": url,
//     "ingredients": List<dynamic>.from(ingredients.map((ingredient) => ingredient)),
//     "results": List<dynamic>.from(results.map((x) => x.toJson())),
//   };
  
//   @override
//   List<Object?> get props => [title, image, kcal, servings, cookingTime, url, ingredients, results];
// }

// class Result extends Equatable{
//   final String title;
//   final String? image;
//   final int kcal;
//   final int? servings;
//   final int? cookingTime;
//   final String? url;
//   final List<String>? ingredients;

//   const Result({
//     required this.title,
//     this.image,
//     required this.kcal,
//     this.servings,
//     this.cookingTime,
//     this.url,
//     this.ingredients,
//   });

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     title: json["title"],
//     image: json['image'],
//     kcal: json['calories'].toInt(),
//     servings: json['yield'].toInt(),
//     cookingTime: json['totalTime'].toInt(),
//     url: json['url'],
//     ingredients: List<String>.from(json['ingredients'].map((ingredient) => ingredient['text'])),
//   );

//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "image": image,
//     "kcal": kcal,
//     "servings": servings,
//     "cookingTime": cookingTime,
//     "url": url,
//     //"ingredients": List<dynamic>.from(ingredients.map((ingredient) => ingredient)),
//     "ingredients": ingredients,
//   };
  
//   @override
//   List<Object?> get props => [title, image, kcal, servings, cookingTime, url, ingredients];
// }



import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchRecipeApiService {
  final String apiKey;
  final String apiUrl = 'https://api.edamam.com/api/recipes/v2';

  SearchRecipeApiService(this.apiKey);

  Future<List<dynamic>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl?type=public&q=$query&app_id=b0eefc7c&app_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['hits'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}

class SearchRecipeModel {
  String title;
  //String image;
  int kcal;
  int servings;
  int cookingTime;
  String url;
  List<bool> takedingredients;
  List<String> ingredients;

  SearchRecipeModel({
    required this.title,
    //required this.image,
    required this.kcal,
    required this.servings,
    required this.cookingTime,
    required this.ingredients,
    required this.url,
  }) : takedingredients = List<bool>.filled(ingredients.length, false);

  // Method to convert a Map to a RecipeModel
  factory SearchRecipeModel.fromMap(Map<String, dynamic> map) {
    return SearchRecipeModel(
      title: map['recipe']['label'],
      //image: map['recipe']['image'],
      kcal: map['recipe']['calories'].toInt(),
      servings: map['recipe']['yield'].toInt(),
      cookingTime: map['recipe']['totalTime'].toInt(),
      url: map['recipe']['url'],
      ingredients: List<String>.from(
          map['recipe']['ingredients'].map((ingredient) => ingredient['text'])),
    );
  }
}
// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';
import 'package:equatable/equatable.dart';

SearchRecipeModel foodModelFromJson(String str) => SearchRecipeModel.fromJson(json.decode(str));

String foodModelToJson(SearchRecipeModel data) => json.encode(data.toJson());

class SearchRecipeModel extends Equatable{

  final List<Result> results;
  final String title;
  final String? image;
  final int kcal;
  final int? servings;
  final int? cookingTime;
  final String? url;
  //final List<bool>? takedingredients;
  final List<String> ingredients;

  const SearchRecipeModel({
    required this.results,
    required this.title,
    this.image,
    required this.kcal,
    this.servings,
    this.cookingTime,
    this.url,
    required this.ingredients,
  });

  factory SearchRecipeModel.fromJson(Map<String, dynamic> json) => SearchRecipeModel(
    title: json["title"],
    image: json['image'],
    kcal: json['calories'].toInt(),
    servings: json['yield'].toInt(),
    cookingTime: json['totalTime'].toInt(),
    url: json['url'],
    ingredients: List<String>.from(json['ingredients'].map((ingredient) => ingredient['text'])),
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title, 
    "image": image,
    "kcal": kcal,
    "servings": servings,
    "cookingTime": cookingTime,
    "url": url,
    "ingredients": List<dynamic>.from(ingredients.map((ingredient) => ingredient)),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
  
  @override
  List<Object?> get props => [title, image, kcal, servings, cookingTime, url, ingredients, results];
}

class Result extends Equatable{
  final String title;
  final String? image;
  final int kcal;
  final int? servings;
  final int? cookingTime;
  final String? url;
  final List<String>? ingredients;

  const Result({
    required this.title,
    this.image,
    required this.kcal,
    this.servings,
    this.cookingTime,
    this.url,
    this.ingredients,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    image: json['image'],
    kcal: json['calories'].toInt(),
    servings: json['yield'].toInt(),
    cookingTime: json['totalTime'].toInt(),
    url: json['url'],
    ingredients: List<String>.from(json['ingredients'].map((ingredient) => ingredient['text'])),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "kcal": kcal,
    "servings": servings,
    "cookingTime": cookingTime,
    "url": url,
    //"ingredients": List<dynamic>.from(ingredients.map((ingredient) => ingredient)),
    "ingredients": ingredients,
  };
  
  @override
  List<Object?> get props => [title, image, kcal, servings, cookingTime, url, ingredients];
}
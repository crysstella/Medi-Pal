import 'package:flutter/foundation.dart';
import 'dart:convert';


class SearchRecipeModel {
  String recipeName;
  String recipeImage;
  String recipeSource;


  SearchRecipeModel({
    this.recipeName= '',
    this.recipeImage = '',
    this.recipeSource = '',

  });

  // Method to convert a Map to a RecipeModel
  factory SearchRecipeModel.fromMap(Map recipe) {
    return SearchRecipeModel(
      recipeName: recipe["label"],
      recipeImage: recipe["image"],
      recipeSource: recipe["url"],
    );
  }
}
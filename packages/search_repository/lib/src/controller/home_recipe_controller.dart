import 'dart:convert';

import 'package:search_repository/src/models/search_recipe_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeRecipeController extends GetxController{

  var itemList = <SearchRecipeModel>[].obs;

  getdata () async {
    final url = 'https://api.edamam.com/search?q=chicken&app_id=a7df912f&app_key=3eb2b5b687d167b85b4f79c47e4c9abb';
    final response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    data["hits"].forEach((element) {

      SearchRecipeModel searchRecipeModel = SearchRecipeModel();
      searchRecipeModel = SearchRecipeModel.fromMap(element['recipe']);
      itemList.add(searchRecipeModel);
    });

    itemList.forEach((element) {
      print(element.recipeName.toString());
    });

  }
}
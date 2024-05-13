import 'dart:convert';
import 'package:search_repository/src/models/search_recipe_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchRecipeController extends GetxController{

  var searchItem = <SearchRecipeModel>[].obs;

  RxBool loading = true.obs;

  getrecipe(String query) async {
    String url = 'https://api.edamam.com/search?q=$query&app_id=a7df912f&app_key=3eb2b5b687d167b85b4f79c47e4c9abb';
    final response = await http.get(Uri.parse(url));
    searchItem.clear();

    Map data = jsonDecode(response.body);
    
    data["hits"].forEach((element){
      SearchRecipeModel searchRecipeModel = SearchRecipeModel();
      searchRecipeModel = SearchRecipeModel.fromMap(element['recipe']);

      searchItem.add(searchRecipeModel);
      loading.value = false;

    });
  }

}
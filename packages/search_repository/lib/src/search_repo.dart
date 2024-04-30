import 'package:search_repository/search_repository.dart';

abstract class SearchRepository {

  Future<List<Result>> searchRecipes({String query});

  //void dispose();
}
// // part of 'search_bloc.dart';

// // abstract class SearchEvent extends Equatable {
// //   const SearchEvent();

// //   @override
// //   List<Object> get props => [];
// // }

// // class SearchInput extends SearchEvent {
// //   final String input;
// //   SearchInput({required this.input});

// // }

// // import 'package:meta/meta.dart';

// // abstract class SearchEvent {}

// // class DrugSearchEvent extends SearchEvent {
// //   final String query;
// //   DrugSearchEvent({@required this.query}) : assert(query != null);
// // }

// // class DiseaseSearchEvent extends SearchEvent {
// //   final String query;
// //   DiseaseSearchEvent({@required this.query}) : assert(query != null);
// // }

// // class SymptomSearchEvent extends SearchEvent {
// //   final String query;
// //   SymptomSearchEvent({@required this.query}) : assert(query != null);
// // }

// part of 'search_bloc.dart';

// @immutable
// abstract class SearchRecipeEvent extends Equatable {

//   const SearchRecipeEvent();
  
//   @override
//   List<Object> get props => [];
// }

// class GetMealsByQuery extends SearchRecipeEvent {
//   final String query;

//   const GetMealsByQuery(this.query);

//   @override
//   List<Object> get props => [query];
// }

// class ListMealsByFirstLetter extends SearchRecipeEvent {
//   final String letter;

//   const ListMealsByFirstLetter(this.letter);

//   @override
//   List<Object> get props => [letter];
// }

// class RefreshEvent extends SearchRecipeEvent {}

// class LoadMoreEvent extends SearchRecipeEvent {}

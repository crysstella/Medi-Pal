// // part of 'search_bloc.dart';

// // abstract class SearchState extends Equatable {
// //   const SearchState();

// //   @override
// //   List<Object> get props => [];
// // }

// // class SearchInitial extends SearchState {}
// // class SearchLoading extends SearchState {}

// // class SearchSuccess extends SearchState {}
// // class SearchFailure extends SearchState {}

// // import 'package:meta/meta.dart';

// // abstract class SearchState {}

// // class SearchUninitialisedState extends SearchState {}

// // class SearchFetchingState extends SearchState {}

// // class SearchDrugFetchedState extends SearchState {
// //   final List<Drug> drugs;
// //   SearchDrugFetchedState({@required this.drugs}) : assert(drugs != null);
// // }

// // class SearchDiseaseFetchedState extends SearchState {
// //   final List<Disease> diseases;
// //   SearchDiseaseFetchedState({@required this.diseases})
// //       : assert(diseases != null);
// // }

// // class SearchSymptomFetchedState extends SearchState {
// //   final List<Symptom> symptoms;
// //   SearchSymptomFetchedState({@required this.symptoms})
// //       : assert(symptoms != null);
// // }

// // class SearchErrorState extends SearchState {}

// // class SearchEmptyState extends SearchState {}


// part of 'search_bloc.dart';

// abstract class SearchRecipeState extends Equatable {
//   const SearchRecipeState();

//   @override
//   List<Object> get props => [];
// }

// class SearchInitial extends SearchRecipeState {}

// class SearchLoading extends SearchRecipeState {}

// class SearchSuccess extends SearchRecipeState {

//   final List<Result> recipes;

//   const SearchSuccess({required this.recipes});
  
//   @override
//   List<Object> get props => [recipes];
// }

// class ResultSuccess extends SearchRecipeState {

//   final List<Result> recipe;

//   const ResultSuccess({required this.recipe});
  
//   @override
//   List<Object> get props => [recipe];
// }

// class SearchFailure extends SearchRecipeState {

// 	final String message;
// 	const SearchFailure({required this.message});

//   @override
//   List<Object> get props => [message];
// }
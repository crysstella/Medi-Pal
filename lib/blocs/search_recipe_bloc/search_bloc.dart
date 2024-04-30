// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'search_event.dart';
// part 'search_state.dart';

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   SearchBloc() : super(SearchInitial()) {
//     on<SearchInput>((event, emit) async{
//       // List <String> searchedArr = [];
//       // for (var element in input) {
//       //   if(element.contains(event.word)) {
//       //     searchedArr.add(element);
//       //   }
//       // }
//       await event.map(
//         searchValueChanged: (e) async {
//           try {
//             emit(SearchLoading());
//             List<dynamic> list = await searchRepository.searchProducts(
//                 searchValue: e.searchValue);
//             if (list.isEmpty) {
//               emit(SearchFailure());
//             } else {
//               emit(SearchSuccess(allData: list));
//             }
//           } catch (e) {
//             print(e);
//           }
//         },
//         valueDeleted: (e) {
//           emit(SearchInitial());
//         },
//       );

//     });
//   }
// }


// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:search_repository/search_repository.dart';

// part 'search_event.dart';
// part 'search_state.dart';

// class SearchRecipeBloc extends Bloc<SearchRecipeEvent, SearchRecipeState> {

//   final SearchRecipeRepository searchRepository;
  
//   //String query;

//   SearchRecipeBloc({ required SearchRecipeRepository searchRepository
//   }) : searchRepository = searchRepository, 
//   super(SearchInitial()){

//     on<SearchRecipeEvent>((event, emit) async {
//       if (event is SearchRecipeEvent) {
//         try {
//           emit(SearchLoading());
//           final results = await repo.getSearchList(event.query, 100);
//           emit(SearchSuccess(
//             recipes: [], 
//             hasReachedEnd: null,
//           ));
//         } on Failure catch (e) {
//           emit(FailureState(error: e));
//         } catch (e) {
//           print(e.toString());
//           emit(SearchFailure());
//         } 
//       }       
//     });

//     on<GetMealsByQuery>((event, emit) async {
//       emit(SearchLoading());
//       final result = await sl<GetMealListUseCase>().call(event.query);

//       result.fold(
//         (failure) => emit(SearchFailure(failure.toString())),
//         (meals) => emit(SearchSuccess(meals)),
//       );
//     });
//   }
// }

// //   SearchRecipeState get initialState => InitialState();

// //   @override
// //   Stream<SearchRecipeState> mapEventToState(SearchRecipeEvent event) async* {
// //     if (event is SearchEvent) {
// //      yield* _mapToSearchEvent(event);
// //     }else if (event is RefreshEvent) {
// //      yield*  _getRecipes(query);
// //     }else if (event is LoadMoreEvent) {
// //      yield* _getRecipes(query, page: pageNumber);
// //     }
// //   }

// //   Stream<SearchRecipeState> _mapToSearchEvent(SearchEvent event) async* {
// //     pageNumber = 1;
// //     query = event.query;
// //     yield InitialState(); // clearing previous list
// //     yield LoadingState(); // showing loading indicator
// //     yield* _getRecipes(event.query); // get recipes
// //   }

// //   Stream<SearchRecipeState> _getRecipes(String query,  {int page = 1}) async* {
// //     var currentState = state;
// //     try{
// //       List<Result> recipeList = await _searchRepository.getRecipeList(query: query, page: page);
// //       if (currentState is SuccessState) {
// //        recipeList =  currentState.recipe + recipeList;
// //       }
// //       pageNumber++;
// //       yield SuccessState(recipe: recipeList, hasReachedEnd: recipeList.isEmpty ? true : false);
// //     }catch (ex) {
// //       if (page == 1) yield FailedState();
// //       else yield SuccessState(recipe: currentState is SuccessState ? currentState.recipe : [], hasReachedEnd: true);
// //     }
// //   }
// // }
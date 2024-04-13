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

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// part 'navigator_event.dart';
// part 'navigator_state.dart';

// class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
//   final GlobalKey<NavigatorState> navigatorKey;

//   NavigatorBloc({this.navigatorKey});

//   @override 
//   dynamic get initialState => "";

//   @override 
//   Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
//     if(event is NavigatorEventPop){
//       navigatorKey.currentState.pop();}
//     // } else if(event is NavigatorEventLaunch){
//     //   navigatorKey.currentState.pushNamed('/launch');
//     // }
//     else if(event is NavigatorEventLogIn){
//       navigatorKey.currentState.pushNamed('/login');
//     }
//     else if(event is NavigatorEventRegister){
//       navigatorKey.currentState.pushNamed('/register');
//     }
//     yield

//   }

// }

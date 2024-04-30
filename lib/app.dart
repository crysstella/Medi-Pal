import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medipal/app_view.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

// class MyApp extends StatefulWidget {
//   final ChangeThemeBloc changeThemeBloc;
//   final UserRepository _userRepository;
//   MyApp({
//     @required this.changeThemeBloc,
//     @required this._userRepository,
//   });

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// User loggedinUser;

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     widget.changeThemeBloc.onDecideThemeChange();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AuthenticationBloc>(
//       create: (context) =>
//           AuthenticationBloc(userRepository: widget.userRepository)
//             ..add(AppStartedEvent()),
//       child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
//         bloc: changeThemeBloc,
//         builder: (BuildContext context, ChangeThemeState state) {
//           return MaterialApp(
//             title: 'Medi-Pal',
//             home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//               bloc: BlocProvider.of<AuthenticationBloc>(context),
//               builder: (BuildContext context, AuthenticationState authstate) {
//                 if (authstate is AuthenticationUninitialisedState) {
//                   return LaunchScreen();
//                 }
//                 if (authstate is AuthenticationAuthenticatedState) {
//                   loggedinUser = User(
//                     address: authstate.address,
//                     email: authstate.email,
//                     imageUrl: authstate.imageUrl,
//                     name: authstate.name,
//                     token: authstate.token,
//                   );
//                   return startApp();
//                 }
//                 if (authstate is AuthenticationUnauthenticatedState) {
//                   return LogIn(
//                     userRepository: widget.userRepository,
//                   );
//                 }
//                 if (authstate is AuthenticationLoadingState) {
//                   return LoadingIndicator();
//                 }
//               },
//             ),
//             routes: <String, WidgetBuilder>{
//               "/launch": (context) => LaunchScreen(),
//               "/login": (context) => LogIn(),
//               "/register": (context) => Register(),
//               // "/about": (context) => AboutPage(),
//               // "/profile": (context) => ProfilePage(),
//               // "/editprofile": (context) => EditProfile(),
//               // "/changepw": (context) => ChangePasswordPage(),
//               // "/forum": (context) => ForumPage(),
//               // "/tools": (context) => HealthToolsPage(),
//               // "/province": (context) => ProvincePage(),
//             },
//             debugShowCheckedModeBanner: false,
//             theme: state.themeData,
//           );
//         },
//       ),
//     );
//   }
// }

//root
class MyApp extends StatelessWidget{
  const MyApp(this.userRepository, {super.key});
  final UserRepository userRepository;
  
  @override
  Widget build(BuildContext context){
    return MultiRepositoryProvider(
      providers: [
				RepositoryProvider<AuthenticationBloc>(
					create: (_) => AuthenticationBloc(  //create provider 
						myUserRepository: userRepository
					)
				)
			], 
			child: const MyAppView()
    );
  }
}
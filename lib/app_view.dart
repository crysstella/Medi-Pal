import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medipal/components/navigation_service/navigationService.dart';
import 'package:medipal/pages/Start/launch.dart';
import 'package:medipal/pages/Start/startApp.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/my_user_bloc/bloc/my_user_bloc.dart';
import 'blocs/log_in_bloc/log_in_bloc.dart';

class MyAppView extends StatelessWidget{
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
		  navigatorKey: navigationService.navigatorKey,
				/*initialRoute: '/',
			routes: {'/': (context) => LoginS,}*/
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9EA0A1FA),
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
				builder: (context, state) {  //returns a widget
					if(state.status == AuthenticationStatus.authenticated) {
						return MultiBlocProvider(
								providers: [
									BlocProvider(
										create: (context) => LogInBloc(
											userRepository: context.read<AuthenticationBloc>().userRepository
										),
									),
									// BlocProvider(
									// 	create: (context) => UpdateUserInfoBloc(
									// 		userRepository: context.read<AuthenticationBloc>().userRepository
									// 	),
									// ),
									BlocProvider(
										create: (context) => MyUserBloc(
											myUserRepository: context.read<AuthenticationBloc>().userRepository
										)..add(GetMyUser(
											myUserEmail: context.read<AuthenticationBloc>().state.user!.uid
										)),
									),
								],
							child: const StartApp(),
						);
					} else {
						return const LaunchScreen();
					}
				}
			),
    );
  }
}
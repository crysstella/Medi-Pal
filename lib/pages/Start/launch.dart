import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medipal/pages/LogIn/login.dart';
import 'package:medipal/pages/Register/register.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/log_in_bloc/log_in_bloc.dart';
import '../../blocs/register_bloc/bloc/register_bloc.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

// only tick while the current tab is enabled
class _LaunchScreenState extends State<LaunchScreen> with TickerProviderStateMixin {
  //swtich between tabs
	late TabController tabController;
	@override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.primaryContainer,
			appBar: AppBar(
				elevation: 0,
				backgroundColor: Colors.transparent,
			),
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Padding(
						padding: const EdgeInsets.symmetric(horizontal: 30),
						child: Column(
							children: [
								const Text(
									'Medi-Pal',
									style: TextStyle(
										fontSize: 32,
										fontWeight: FontWeight.bold
									),
								),
								const SizedBox(height: kToolbarHeight),
								TabBar(
									controller: tabController,
									unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
									labelColor: Theme.of(context).colorScheme.onBackground,
									tabs: const [
										Padding(
											padding: EdgeInsets.all(12.0),
											child: Text(
												'Log In',
												style: TextStyle(
													fontSize: 16,
												),
											),
										),
										Padding(
											padding: EdgeInsets.all(12.0),
											child: Text(
												'Register',
												style: TextStyle(
													fontSize: 16,
												),
											),
										),
									]
								),
                
								Expanded(
									child: TabBarView(
										controller: tabController,
										children: [
											BlocProvider<LogInBloc>(
												create: (context) => LogInBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const LogInScreen(),
											),
											BlocProvider<RegisterBloc>(
												create: (context) => RegisterBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const RegisterScreen(),
											),
										]
									),
								)
							],
						),
					),
				),
			),
		);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';
import 'package:user_repository/user_repository.dart';
import '../../blocs/register_bloc/bloc/register_bloc.dart';
import '../../components/my_text_field.dart';
import '../../components/strings.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
	final emailController = TextEditingController();
  final birthdayController = TextEditingController();
  // final heightController = TextEditingController();
  // final weightController = TextEditingController();
	final passwordController = TextEditingController();

  bool passwordToggle = true;
	bool registerRequired = false;

	// bool containsUpperCase = false;
	// bool containsLowerCase = false;
	// bool containsNumber = false;
	// bool containsSpecialChar = false;
	// bool contains8Length = false;

  // late AuthenticationBloc authBloc;
  // late LogInBloc loginBloc;

  // @override
  // void initState() {
  //   authBloc = BlocProvider.of<AuthenticationBloc>(context);
  //   loginBloc = BlocProvider.of<LogInBloc>(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
				if(state is RegisterSuccess) {
					setState(() {
					  registerRequired = false;
					});
				} else if(state is RegisterProcess) {
					setState(() {
					  registerRequired = true;
					});
				} else if(state is RegisterFailure) {
					return;
				}
			},
      child: Form(
        key: _formKey,
				child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(                                       //full name
                padding: const EdgeInsets.all(12),
			  				child: MyTextField(
                  controller: nameController,
										hintText: 'Full Name',
										obscureText: false,
										keyboardType: TextInputType.name,
										prefixIcon: const Icon(UniconsLine.user),
										validator: (val) {
											if(val!.isEmpty) {
												return 'Please complete this field';
											} else if(val.length > 30) {
												return 'Name too long';
											}
											return null;
										}
                )
              ),
              const SizedBox(height: 2),
              Padding(                                        //email
                padding: const EdgeInsets.all(12),
			  				child: MyTextField(
			  					controller: emailController,
			  					hintText: 'E-mail',
			  					obscureText: false,
			  					keyboardType: TextInputType.emailAddress,
			  					prefixIcon: const Icon(UniconsLine.envelope),
			  					validator: (val) {
			  						if(val!.isEmpty) {
			  							return 'Please fill in this field';
			  						} else if(!emailRexExp.hasMatch(val)) {
			  							return 'Please enter a valid email';
			  						}
			  						return null;
			  					}
			  				),
			  			),

              const SizedBox(height: 2),
              /*Padding(                                       //bday
                padding: const EdgeInsets.all(12),
			  				child: MyTextField(
			  					controller: birthdayController,
			  					hintText: 'Birthday',
			  					obscureText: false,
			  					keyboardType: TextInputType.datetime,
			  					prefixIcon: const Icon(UniconsLine.calender),
			  					validator: (val) {
			  						if(val!.isEmpty) {
			  							return 'Please fill in this field';
			  						} else if(!emailRexExp.hasMatch(val)) {
			  							return 'Please enter a valid date';
			  						}
			  						return null;
			  					}
			  				),
			  			),

              const SizedBox(height: 2),
              //Row(children: [
                 Padding(                                       //height
                padding: const EdgeInsets.all(12),
			  				child: MyTextField(
			  					controller: heightController,
			  					hintText: 'Height',
			  					obscureText: false,
			  					keyboardType: TextInputType.datetime,
			  					prefixIcon: const Icon(UniconsLine.ruler),
			  					validator: (val) {
			  						if(val!.isEmpty) {
			  							return 'Please fill in this field';
			  						} else if(!emailRexExp.hasMatch(val)) {
			  							return 'Please enter a valid number';
			  						}
			  						return null;
			  					}
			  				),
			  			),

              const SizedBox(height: 2),
              Padding(                                       //weight
                padding: const EdgeInsets.all(12),
			  				child: MyTextField(
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
			  					controller: weightController,
			  					hintText: 'Weight',
			  					obscureText: false,
			  					keyboardType: TextInputType.number,
			  					prefixIcon: const Icon(UniconsLine.balance_scale),
			  					validator: (val) {
			  						if(val!.isEmpty) {
			  							return 'Please fill in this field';
			  						} else if(!emailRexExp.hasMatch(val)) {
			  							return 'Please enter a valid number';
			  						}
			  						return null;
			  					}
			  				),
			  			),
              //],),*/

              const SizedBox(height: 2),
              Padding(                                       //password
                padding: const EdgeInsets.all(12),
			  				child: MyTextField(
			  					controller: passwordController,
			  					hintText: 'Password',
			  					obscureText: passwordToggle,
			  					keyboardType: TextInputType.visiblePassword,
			  					prefixIcon: const Icon(UniconsLine.lock),
			  					// onChanged: (val) {
									// 	if(val!.contains(RegExp(r'[A-Z]'))) {
									// 		setState(() {
									// 			containsUpperCase = true;
									// 		});
									// 	} else {
									// 		setState(() {
									// 			containsUpperCase = false;
									// 		});
									// 	}
									// 	if(val.contains(RegExp(r'[a-z]'))) {
									// 		setState(() {
									// 			containsLowerCase = true;
									// 		});
									// 	} else {
									// 		setState(() {
									// 			containsLowerCase = false;
									// 		});
									// 	}
									// 	if(val.contains(RegExp(r'[0-9]'))) {
									// 		setState(() {
									// 			containsNumber = true;
									// 		});
									// 	} else {
									// 		setState(() {
									// 			containsNumber = false;
									// 		});
									// 	}
									// 	if(val.contains(specialCharRexExp)) {
									// 		setState(() {
									// 			containsSpecialChar = true;
									// 		});
									// 	} else {
									// 		setState(() {
									// 			containsSpecialChar = false;
									// 		});
									// 	}
									// 	if(val.length >= 8) {
									// 		setState(() {
									// 			contains8Length = true;
									// 		});
									// 	} else {
									// 		setState(() {
									// 			contains8Length = false;
									// 		});
									// 	}
									// 	return null;
									// 	},
                    suffixIcon: IconButton(
											onPressed: () {
												setState(() {
													passwordToggle = !passwordToggle;
													if(passwordToggle) {
														const Icon(UniconsLine.eye);
                          } else {
                            const Icon(UniconsLine.eye_slash);
													}
												});
											},
											icon: const Icon(UniconsLine.eye),
										),
										validator: (val) {
											if(val!.isEmpty) {
												return 'Please enter in your e=mail';
											} else if(!passwordRexExp.hasMatch(val)) {
												return 'Please enter a valid password';
											}
											return null;
										}
			  				),
			  			),
              //Register
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
								!registerRequired ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
											child: TextButton(
                        onPressed: () {
													if (_formKey.currentState!.validate()) {
														MyUserModel myUser = MyUserModel.empty;
														myUser = myUser.copyWith(
															email: emailController.text,
															name: nameController.text,
														);

														setState(() {
															context.read<RegisterBloc>().add(
																RegisterRequired(
																	myUser,
																	passwordController.text
																)
															);
														});
													}
												},
                        style: TextButton.styleFrom(
													elevation: 3.0,
													backgroundColor: Theme.of(context).colorScheme.primary,
													foregroundColor: Colors.white,
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(60)
													)
												),

                        child: const Padding(
													padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
													child: Text(
														'Register',
														textAlign: TextAlign.center,
														style: TextStyle(
															color: Colors.white,
															fontSize: 16,
															fontWeight: FontWeight.w600
														),
													),
												)
                      ),
                ) :const CircularProgressIndicator()
            ],
          ),
        ),
      ),

    );
  }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     color: Theme.of(context).secondaryHeaderColor,
  //     child: SingleChildScrollView(
  //       child: SafeArea(
  //         child: Column(
  //           children: [
  //             SizedBox(height: 40),
  //             Padding(
  //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   labelText: "Full Name",
  //                   border: OutlineInputBorder(),
  //                   prefixIcon: Icon(UniconsLine.user),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   labelText: "E-mail Address",
  //                   border: OutlineInputBorder(),
  //                   prefixIcon: Icon(UniconsLine.envelope),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   labelText: "Enter Password",
  //                   border: OutlineInputBorder(),
  //                   prefixIcon: Icon(UniconsLine.lock),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(12),
  //               child: TextField(
  //                 obscureText: passToggle ? true : false,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   label: Text("Re-enter Password"),
  //                   prefixIcon: Icon(UniconsLine.lock),
  //                   suffixIcon: InkWell(
  //                     onTap: () {
  //                       if (passToggle == true) {
  //                         passToggle = false;
  //                       } else {
  //                         passToggle = true;
  //                       }
  //                       setState(() {});
  //                     },
  //                     child: passToggle
  //                         ? Icon(UniconsLine.eye_slash)
  //                         : Icon(UniconsLine.eye),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             InkWell(
  //               onTap: () {},
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(vertical: 15),
  //                 width: 350,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Theme.of(context).colorScheme.primary,
  //                       blurRadius: 4,
  //                       spreadRadius: 2,
  //                     ),
  //                   ],
  //                 ),
  //                 child: Center(
  //                   child: Text(
  //                       "Register",
  //                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
  //                         color: Theme.of(context).colorScheme.onPrimary,
  //                       )
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                     "Already have an account?",
  //                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
  //                       color: Theme.of(context).colorScheme.primary,
  //                     )
  //                 ),
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => loginScreen(),
  //                         ));
  //                   },
  //                   child: Text(
  //                       "Log In",
  //                       style: Theme.of(context).textTheme.titleSmall!.copyWith(
  //                         color: Theme.of(context).colorScheme.onPrimaryContainer,
  //                       )
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
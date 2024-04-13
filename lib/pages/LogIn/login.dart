import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../blocs/log_in_bloc/log_in_bloc.dart';
import '../../components/my_text_field.dart';
import '../../components/strings.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordToggle = true;
  String? _errorMsg;
  bool logInRequired = false;

  @override 
  Widget build(BuildContext context) {
    return BlocListener<LogInBloc, LogInState>(
        listener: (context, state) {
        if(state is LogInSuccess) {
					setState(() {
					  logInRequired = false;
					});
				} else if(state is LogInProcess) {
					setState(() {
					  logInRequired = true;
					});
				} else if(state is LogInFailure) {
					setState(() {
					  logInRequired = false;
						_errorMsg = 'Please re-check your email or password';
					});
				}
      },
    child: Form(
      key: _formKey,
      child: Column(  //email and password input
        children: [
          const SizedBox(height: 30),  
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,

            child: MyTextField(   //validator
              controller: emailController,
              hintText: 'E-mail',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(UniconsLine.envelope),
              errorMsg: _errorMsg,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!emailRexExp.hasMatch(val)) {
                  return 'Please enter a valid e-mail';
                }
                return null;
              }),
          ),
          const SizedBox(height: 10),  

          SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: passwordToggle,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(UniconsLine.lock),
              errorMsg: _errorMsg,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!passwordRexExp.hasMatch(val)) {
                  return 'Please enter a valid password';
                }
                return null;
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordToggle = !passwordToggle;
                    if (passwordToggle) {   
                      const Icon(UniconsLine.eye);
                    } else {
                      const Icon(UniconsLine.eye_slash);
                    }
                  });
                },
                icon: const Icon(UniconsLine.eye_slash),
              ),
            ),
          ),

          const SizedBox(height: 40),  
          !logInRequired ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LogInBloc>().add(LogInRequired(
                      emailController.text,
                      passwordController.text));
                  }
                },
                style: TextButton.styleFrom(
                  elevation: 3.0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25, vertical: 5),
                  child: Text(
                     'Log In',
                    textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w600),
                     ),
                )),
          )
          : const CircularProgressIndicator()
        ],
      )),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     color: Theme.of(context).primaryColor,
  //     child: SingleChildScrollView(
  //       child: SafeArea(
  //         child: Column(
  //           children: [
  //             SizedBox(height: 40),  //email and password input
  //             Padding(
  //               padding: const EdgeInsets.all(12),
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   label: Text("Enter E-mail"),
  //                   prefixIcon: Icon(UniconsLine.envelope),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(12),
  //               child: TextField(
  //                 obscureText: passToggle ? true : false,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   label: Text("Enter Password"),
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
  //             Padding(
  //               padding: const EdgeInsets.all(15),
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => StartApp(),
  //                       ));
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(vertical: 15),
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Theme.of(context).colorScheme.primaryContainer,
  //                         blurRadius: 4,
  //                         spreadRadius: 2,
  //                       ),
  //                     ],
  //                   ),
  //                   child: Center(
  //                     //   TextButton(
  //                     //     onPressed: () {
  //                     //     Navigator.push(
  //                     //       context,
  //                     //       MaterialPageRoute(
  //                     //         builder: (context) => searchScreen(),
  //                     //       ));
  //                     //     },
  //                     //   child: Text(
  //                     //     "Log In",
  //                     //     style: Theme.of(context).textTheme.titleMedium!.copyWith(
  //                     //       color: Theme.of(context).colorScheme.onPrimaryContainer,
  //                     // )
  //                     // ),
  //                     // ),
  //                     child: Text(
  //                         "Log In",
  //                         style: Theme.of(context).textTheme.titleMedium!.copyWith(
  //                           color: Theme.of(context).colorScheme.onPrimaryContainer,
  //                         )
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 30),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                     "Don't have any account?",
  //                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
  //                       color: Theme.of(context).colorScheme.onPrimary,
  //                     )
  //                 ),
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => registerScreen(),
  //                         )); //navigation to register screen
  //                   },
  //                   child: Text(
  //                       "Register for Account",
  //                       style: Theme.of(context).textTheme.titleSmall!.copyWith(
  //                         color: Theme.of(context).colorScheme.onPrimary,
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
}
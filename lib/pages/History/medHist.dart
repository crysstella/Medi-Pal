// //stateful can change
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:unicons/unicons.dart';

// class MedHistoryScreen extends StatefulWidget {
//   final String userEmail = "a@gmail.com";

//   const MedHistoryScreen({super.key});
//   @override
//   _MedHistoryScreenState createState() => _MedHistoryScreenState();
// }
// class _MedHistoryScreenState extends State<MedHistoryScreen> {
//   final heightController = TextEditingController();
//   final weightController = TextEditingController();
//   //initializes firestore instance so we can access firebase
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<RegisterBloc, RegisterState>(
//       listener: (context, state) {
// 				if(state is RegisterSuccess) {
// 					setState(() {
// 					  registerRequired = false;
// 					});
// 				} else if(state is RegisterProcess) {
// 					setState(() {
// 					  registerRequired = true;
// 					});
// 				} else if(state is RegisterFailure) {
// 					return;
// 				}
// 			},
//       child: Form(
//         key: _formKey,
// 				child: Center(
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               /*Padding(                                       //bday
//                 padding: const EdgeInsets.all(12),
// 			  				child: MyTextField(
// 			  					controller: birthdayController,
// 			  					hintText: 'Birthday',
// 			  					obscureText: false,
// 			  					keyboardType: TextInputType.datetime,
// 			  					prefixIcon: const Icon(UniconsLine.calender),
// 			  					validator: (val) {
// 			  						if(val!.isEmpty) {
// 			  							return 'Please fill in this field';
// 			  						} else if(!emailRexExp.hasMatch(val)) {
// 			  							return 'Please enter a valid date';
// 			  						}
// 			  						return null;
// 			  					}
// 			  				),
// 			  			),

//               const SizedBox(height: 2),
//               //Row(children: [
//                  Padding(                                       //height
//                 padding: const EdgeInsets.all(12),
// 			  				child: MyTextField(
// 			  					controller: heightController,
// 			  					hintText: 'Height',
// 			  					obscureText: false,
// 			  					keyboardType: TextInputType.datetime,
// 			  					prefixIcon: const Icon(UniconsLine.ruler),
// 			  					validator: (val) {
// 			  						if(val!.isEmpty) {
// 			  							return 'Please fill in this field';
// 			  						} else if(!emailRexExp.hasMatch(val)) {
// 			  							return 'Please enter a valid number';
// 			  						}
// 			  						return null;
// 			  					}
// 			  				),
// 			  			),

//               const SizedBox(height: 2),
//               Padding(                                       //weight
//                 padding: const EdgeInsets.all(12),
// 			  				child: MyTextField(
//                   maxLengthEnforcement: MaxLengthEnforcement.enforced,
// 			  					controller: weightController,
// 			  					hintText: 'Weight',
// 			  					obscureText: false,
// 			  					keyboardType: TextInputType.number,
// 			  					prefixIcon: const Icon(UniconsLine.balance_scale),
// 			  					validator: (val) {
// 			  						if(val!.isEmpty) {
// 			  							return 'Please fill in this field';
// 			  						} else if(!emailRexExp.hasMatch(val)) {
// 			  							return 'Please enter a valid number';
// 			  						}
// 			  						return null;
// 			  					}
// 			  				),
// 			  			),
//               //],),*/
//               //Register
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
// 								!registerRequired ? SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.5,
// 											child: TextButton(
//                         onPressed: () {
// 													if (_formKey.currentState!.validate()) {
// 														MyUserModel myUser = MyUserModel.empty;
// 														myUser = myUser.copyWith(
// 															email: emailController.text,
// 															name: nameController.text,
// 														);

// 														setState(() {
// 															context.read<RegisterBloc>().add(
// 																RegisterRequired(
// 																	myUser,
// 																	passwordController.text
// 																)
// 															);
// 														});
// 													}
// 												},
//                         style: TextButton.styleFrom(
// 													elevation: 3.0,
// 													backgroundColor: Theme.of(context).colorScheme.primary,
// 													foregroundColor: Colors.white,
// 													shape: RoundedRectangleBorder(
// 														borderRadius: BorderRadius.circular(60)
// 													)
// 												),

//                         child: const Padding(
// 													padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
// 													child: Text(
// 														'Register',
// 														textAlign: TextAlign.center,
// 														style: TextStyle(
// 															color: Colors.white,
// 															fontSize: 16,
// 															fontWeight: FontWeight.w600
// 														),
// 													),
// 												)
//                       ),
//                 ) :const CircularProgressIndicator()
//             ],
//           ),
//         ),
//       ),

//     );
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   //returns the screen
//   //   return Scaffold(
//   //     //the top bar
//   //     appBar: AppBar(
//   //       //writes the title of Health Assessment on top of Screen
//   //       title: const Text("Medical History"),
//   //     ),
//   //     body: Center(
//   //       child: Column(
//   //         //aligns the text more on
//   //         // mainAxisAlignment: MainAxisAlignment.center,S
//   //         crossAxisAlignment: CrossAxisAlignment.start,

//   //         children: [
//   //           const Text(
//   //             //Write prompt on why they should do the health assessment for the app to be effective
//   //               "Hello New User! Please complete your profile to use this app effectively.",
//   //               style: TextStyle(
//   //                   fontSize: 20,
//   //                   fontStyle: FontStyle.italic,
//   //                   color: Colors.black)),
//   //           //vertical spacing added between the text
//   //                         const SizedBox(height: 2),
//   //             Row(children: [
//   //                Padding(                                       //height
//   //               padding: const EdgeInsets.all(12),
// 	// 		  				child: MyTextField(
// 	// 		  					controller: heightController,
// 	// 		  					hintText: 'Height',
// 	// 		  					obscureText: false,
// 	// 		  					keyboardType: TextInputType.datetime,
// 	// 		  					prefixIcon: const Icon(UniconsLine.ruler),
// 	// 		  					validator: (val) {
// 	// 		  						if(val!.isEmpty) {
// 	// 		  							return 'Please fill in this field';
// 	// 		  						} else if(!emailRexExp.hasMatch(val)) {
// 	// 		  							return 'Please enter a valid number';
// 	// 		  						}
// 	// 		  						return null;
// 	// 		  					}
// 	// 		  				),
// 	// 		  			),

//   //             const SizedBox(height: 2),
//   //             Padding(                                       //weight
//   //               padding: const EdgeInsets.all(12),
// 	// 		  				child: MyTextField(
//   //                 maxLengthEnforcement: MaxLengthEnforcement.enforced,
// 	// 		  					controller: weightController,
// 	// 		  					hintText: 'Weight',
// 	// 		  					obscureText: false,
// 	// 		  					keyboardType: TextInputType.number,
// 	// 		  					prefixIcon: const Icon(UniconsLine.balance_scale),
// 	// 		  					validator: (val) {
// 	// 		  						if(val!.isEmpty) {
// 	// 		  							return 'Please fill in this field';
// 	// 		  						} else if(!emailRexExp.hasMatch(val)) {
// 	// 		  							return 'Please enter a valid number';
// 	// 		  						}
// 	// 		  						return null;
// 	// 		  					}
// 	// 		  				),
// 	// 		  			),
//   //             //],),
//   //           const SizedBox(height: 20.0),
//   //           TextField(
//   //             //textBox for user to type in
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 //assigns users input to input Value
//   //                 _inputValue = value;
//   //               });
//   //             },
//   //             decoration: const InputDecoration(
//   //               //gives text to prompt user to enter Disease
//   //                 labelText: "Birthday: ",
//   //                 // changes the font style and color of the text
//   //                 labelStyle: TextStyle(
//   //                     fontSize: 20,
//   //                     fontStyle: FontStyle.italic,
//   //                     color: Colors.black)),
//   //           ),
//   //           const SizedBox(height: 20.0),
//   //           //created a button for user to interact with when they need to move onto the next screen
//   //           ElevatedButton(
//   //             //when presses calls save Disease function
//   //             onPressed: _saveHistory,
//   //             child: const Text("Save"),
//   //           ),
//   //         ],
//   //       ),]
//   //     ),)
//   //   );
//   // }
// }

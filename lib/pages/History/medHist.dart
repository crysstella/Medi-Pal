// //stateful can change
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'historyInfo.dart';

// class MedHistoryScreen extends StatefulWidget {
//   final String userEmail = "a@gmail.com";

//   const MedHistoryScreen({super.key});
//   @override
//   //initializes the state for InputScreenState
//   _MedHistoryScreenState createState() => _MedHistoryScreenState();
// }

// class _MedHistoryScreenState extends State<MedHistoryScreen> {
//   // initialize input value as an empty string
//   String _inputValue = "";
//   //initializes firestore instance so we can access firebase
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void _saveHistory() {
//     //if input is not null
//     if (_inputValue.isNotEmpty) {
//       //add thhe users input to firestore with a timestamp
//       //userInput is the collection name
//       _firestore.collection("users").add({
//         //set inputValue to be saved in userInput collection
//         "input": _inputValue,
//         //set the timestamp in firestore when input is collected
//         "timestamp": DateTime.now(),
//       }).then((value) {
//         // navigates to DiseaseInfoScreen after saving
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                 //passes in the userInput
//                 HistoryInfoScreen(userHistory: _inputValue)));
//         //catch error just in case there is a failure with the input
//       }).catchError((error) {
//         //prints error
//         print("Failed to save input: $error");
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //returns the screen
//     return Scaffold(
//       //the top bar
//       appBar: AppBar(
//         //writes the title of Health Assessment on top of Screen
//         title: const Text("Medical History"),
//       ),
//       body: Center(
//         child: Column(
//           //aligns the text more on
//           // mainAxisAlignment: MainAxisAlignment.center,S
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             const Text(
//               //Write prompt on why they should do the health assessment for the app to be effective
//                 "Hello New User! Please complete your profile to use this app effectively.",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontStyle: FontStyle.italic,
//                     color: Colors.black)),
//             //vertical spacing added between the text
//             const SizedBox(height: 20.0),
//             TextField(
//               //textBox for user to type in
//               onChanged: (value) {
//                 setState(() {
//                   //assigns users input to input Value
//                   _inputValue = value;
//                 });
//               },
//               decoration: const InputDecoration(
//                 //gives text to prompt user to enter Disease
//                   labelText: "Enter any Diseases you may have:",
//                   // changes the font style and color of the text
//                   labelStyle: TextStyle(
//                       fontSize: 20,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.black)),
//             ),
//             const SizedBox(height: 20.0),
//             //created a button for user to interact with when they need to move onto the next screen
//             ElevatedButton(
//               //when presses calls save Disease function
//               onPressed: _saveHistory,
//               child: const Text("Save"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

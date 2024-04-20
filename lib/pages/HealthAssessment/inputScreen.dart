//stateful can change
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'diseaseInfo.dart';

class InputScreen extends StatefulWidget {
  final String userEmail;

  const InputScreen({Key? key, required this.userEmail}) : super(key: key);
  @override
  //initializes the state for InputScreenState
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // initialize input value as an empty string
  String _inputValue = "";
  //initializes firestore instance so we can access firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveDisease() {
    //if input is not null
    if (_inputValue.isNotEmpty) {
      //add the users input to firestore with a timestamp
      //userInput is the collection name
      _firestore.collection("users").add({
        //set inputValue to be saved in userInput collection
        "input": _inputValue,
        //set the timestamp in firestore when input is collected
        "timestamp": DateTime.now(),
      }).then((value) {
        // navigates to DiseaseInfoScreen after saving
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                //passes in the userInput
                DiseaseInfoScreen(userDisease: _inputValue)));
        //catch error just in case there is a failure with the input
      }).catchError((error) {
        //prints error
        print("Failed to save input: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //returns the screen
    return Scaffold(
      //the top bar
      appBar: AppBar(
        //writes the title of Health Assessment on top of Screen
        title: const Text("Health Assessment"),
      ),
      body: Center(
        child: Column(
          //aligns the text more on
          // mainAxisAlignment: MainAxisAlignment.center,S
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              //Write prompt on why they should do the health assessment for the app to be effective
                "Hello New User! To use this app to the utmost effectiveness, completing the health assessment is highly recommended.",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.black)),
            //vertical spacing added between the text
            const SizedBox(height: 20.0),
            TextField(
              //textBox for user to type in
              onChanged: (value) {
                setState(() {
                  //assigns users input to input Value
                  _inputValue = value;
                });
              },
              decoration: const InputDecoration(
                //gives text to prompt user to enter Disease
                  labelText: "Enter any Diseases you may have:",
                  // changes the font style and color of the text
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
            ),
            const SizedBox(height: 20.0),
            //created a button for user to interact with when they need to move onto the next screen
            ElevatedButton(
              //when presses calls save Disease function
              onPressed: _saveDisease,
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}

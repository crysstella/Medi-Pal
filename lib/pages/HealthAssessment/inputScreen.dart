import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../sharedPref.dart';

import 'diseaseInfo.dart';

class InputScreen extends StatefulWidget {
  final String? email;

  const InputScreen({Key? key, required this.email}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Assessment"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add your medical history:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "To use Medi-Pal and its features to the utmost effectiveness, we recommend completing the health assessment.",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 80.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _inputValue = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "ENTER DISEASE:",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  _saveDisease();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseaseInfoScreen(userDisease: _inputValue),
                    ),
                  );
                },
                 style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.tertiaryContainer), 
                 ),
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }

    //saves disease into firestore
  void _saveDisease() {
  if (_inputValue.isNotEmpty) {

    FirebaseFirestore.instance.collection("users").doc(widget.email).set(
      {
        "userDisease": _inputValue,
      },
      SetOptions(merge: true), 
    ).then((value) {
      //pushes into diseaseInfo Screen after and passes userDisease too
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiseaseInfoScreen(userDisease: _inputValue),
        ),
      );
    }).catchError((error) {
      print("Failed to save input: $error");
    });
  }
}
}
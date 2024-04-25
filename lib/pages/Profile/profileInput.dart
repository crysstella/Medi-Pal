import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInput extends StatefulWidget {
  final Future<String?> email;

  const ProfileInput({Key? key, required this.email}) : super(key: key);

  @override
  _ProfileInputState createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInput> {
  late String _birthday = "";
  late String _height = "Select Your Height";
  late String _weight = "";
  List<String> _heightOptions = ["4'8", "4'9", "4'10", "4'11", "5'0", "5'1", "5'2", "5'3", "5'4", "5'5", "5'6",
    "5'7", "5'8", "5'9", "5'10", "5'11", "6'0", "6'1", "6'2", "6'3", "6'4", "6'5", "6'6", "6'7", "6'8", "6'9", "6'10"];

  @override
  void initState() {
    super.initState();
    _userEmail = widget.email;
  }

  late Future<String?> _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Input"),
      ),
      body: FutureBuilder<String?>(
        future: _userEmail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return _buildProfileInput(snapshot.data);
          }
        },
      ),
    );
  }

  Widget _buildProfileInput(String? email) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Here you can edit your profile by inputting your height, weight, and birthday",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                _birthday.isEmpty ? 'Select your Birthday' : _birthday,
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 22.0),
            DropdownButtonFormField<String>(
              value: _height,
              onChanged: (value) {
                setState(() {
                  _height = value!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: "Select Your Height",
                  child: Text("Select Your Height"),
                ),
                ..._heightOptions.map((String heightOption) {
                  return DropdownMenuItem<String>(
                    value: heightOption,
                    child: Text(heightOption),
                  );
                }).toList(),
              ],
              // decoration: const InputDecoration(
              //   labelText: "Select your Height:",
              //   labelStyle: TextStyle(
              //     fontSize: 20,
              //     fontStyle: FontStyle.italic,
              //     color: Colors.black,
              //   ),
              // ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                _weight = value;
              },
              decoration: const InputDecoration(
                labelText: "Enter your Weight:",
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveProfile(email);
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthday = picked.toString();
      });
    }
  }

  void _saveProfile(String? email) {
    if (_birthday.isNotEmpty && _height != "Select Your Height" && _weight.isNotEmpty) {
      FirebaseFirestore.instance.collection("users").doc(email).set(
        {
          "Birthday": _birthday,
          "Height": _height,
          "Weight": _weight,
        },
        SetOptions(merge: true), // Merge with existing data
      ).then((value) {
        // Success
      }).catchError((error) {
        print("Failed to save profile: $error");
      });
    } else {
      print("Please fill in all fields");
    }
  }
}

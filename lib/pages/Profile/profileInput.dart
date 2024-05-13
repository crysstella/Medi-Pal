import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfileInput extends StatefulWidget {
  final Future<String?> email;

  const ProfileInput({Key? key, required this.email}) : super(key: key);

  @override
  _ProfileInputState createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInput> {
  //initialize input first
  late String _birthday = "";
  late String _height = "Select Your Height";
  late String _weight = "";
  late Future<String?> _userEmail;
  List<String> _heightOptions = ["4'8", "4'9", "4'10", "4'11", "5'0", "5'1", "5'2", "5'3", "5'4", "5'5", "5'6",
    "5'7", "5'8", "5'9", "5'10", "5'11", "6'0", "6'1", "6'2", "6'3", "6'4", "6'5", "6'6", "6'7", "6'8", "6'9", "6'10"];

  //initalize state first to get email
  @override
  void initState() {
    super.initState();
    _userEmail = widget.email;
  }


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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit your profile by inputting your height, weight, and birthday",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32.0),
            //call select Date function here
            Text(
              "SELECT YOUR BIRTHDAY",
              style: TextStyle(
                fontSize: 18,
                //fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4.0),
            TextButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width * 0.40, 20)),
                  padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10)),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0),
                  ),
                ),  
                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
              ),
              child: Text(
                _birthday.isEmpty ? 'D.O.B' : _birthday,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 26.0),
            //when user clicks a date to be selected it will be initialized to height
            DropdownButtonFormField<String>(
              value: _height,
              onChanged: (value) {
                setState(() {
                  _height = value!;
                });
              },
              items: [
                //create menu from height arr
                DropdownMenuItem<String>(
                  value: "Select Your Height",
                  child: Text("CHOOSE YOUR HEIGHT",
                   style: TextStyle(
                     fontSize: 18,
                     color: Theme.of(context).colorScheme.primary,
                  )),
                ),
                //list each element of the array for the menu
                ..._heightOptions.map((String heightOption) {
                  return DropdownMenuItem<String>(
                    value: heightOption,
                    child: Text(heightOption),
                  );
                }),
              ],
            ),
            //enter weight here
            const SizedBox(height: 24.0),
            TextFormField(
              onChanged: (value) {
                _weight = value;
              },
              decoration: InputDecoration(
                labelText: "ENTER YOUR WEIGHT:",
                labelStyle: TextStyle(
                  fontSize: 18,
                  //fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null && int.tryParse(value) == null) {
                  return 'Please enter a valid integer weight';
                }
                return null;
              },
            ),
            const SizedBox(height: 26.0),
            ElevatedButton(
              onPressed: () {
                //validate the form before calling _saveProfile
                if (_formKey.currentState!.validate()) {
                  _saveProfile(email);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary), 
                 ),
              child: Text("Next", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
            ),
          ],
        ),
      ),
    ),
  );
}


 //produces calendar for user to select their birthday
Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null) {
    //format the picked date without the time part
    String formattedDate = DateFormat('MM-dd-yyyy').format(picked);
    
    setState(() {
      _birthday = formattedDate; //set the formatted date
    });
  }
}
  
//function to save user profile
void _saveProfile(String? email) {
  if (_birthday.isNotEmpty && _height != "Select Your Height" && _weight.isNotEmpty) {
    //check if the weight is a valid integer
    int? weightInt = int.tryParse(_weight);
    if (weightInt != null) {
      FirebaseFirestore.instance.collection("users").doc(email).set(
        {
          "birthday": _birthday,
          "height": _height,
          "weight": weightInt,
        },
        //initializes birthday, height, weight for all variables, so duplicates can't exist
        SetOptions(merge: true),
      ).then((value) {
        //displays to user when they are done inputting
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Information uploaded successfully'),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
        );
      }).catchError((error) {
        //anhdle error
        print("Failed to save profile: $error");
      });
    } else {
      //handle invalid weight input
      print("Please enter a valid integer weight");
    }
  } else {
    print("Please fill in all fields");
  }
}

}
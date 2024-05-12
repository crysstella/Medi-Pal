import 'package:flutter/material.dart';
import '../../pages/HealthAssessment/inputScreen.dart';
import '../../pages/medicineDisplay/medicineInfo.dart';
import '../../pages/Profile/profileScreen.dart';
import '../../pages/Profile/profileInput.dart';
import '../../sharedPref.dart';


// import 'package:flutter/material.dart';
// import 'package:medipal/components/pages/HealthAssessment/inputScreen.dart';
// import 'package:medipal/components/pages/medicineDisplay/medicineInfo.dart';
// import 'profileScreen.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<String?> email;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    // Initialize email in initState
    email = getEmail();
    // Set the userEmail when email is resolved
    email.then((value) {
      setState(() {
        userEmail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(email: userEmail),
                  ),
                );
              },
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

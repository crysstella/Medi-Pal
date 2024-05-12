import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../pages/Profile/profileInput.dart';
import '../../sharedPref.dart';
import '../HealthAssessment/inputScreen.dart';


class HomePage extends StatefulWidget {
  //static const String routeName = "/homePage";
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<String?> email;
    late Future<String?> name;
  String? userEmail;
  String? userName;

  @override
  void initState() {
    super.initState();
    // Initialize email in initState
    email = getEmail();
    name = getName();
    // Set the userEmail when email is resolved
    email.then((value) {
      setState(() {
        userEmail = value;
      });
    });

    name.then((value) {
      setState(() {
        userName = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget _header() {
      Widget _btnEdit(
          {required String title,
          required IconData icon,
          required Function onTap,
          required Color backgroundcolor}) {
          return Flexible(
            child: TextButton(
              onPressed: () => onTap(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20, color: Colors.black),
                  const SizedBox(width: 4.0),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width * 0.40, 62)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12)),
                backgroundColor:
                    MaterialStateProperty.all(backgroundcolor), //Background Color
                elevation: MaterialStateProperty.all(4), //Defines Elevation
                shadowColor: MaterialStateProperty.all(Colors.grey), //Define
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
        );
      }

      return Container(
        padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 2),
            Text(
              "Welcome user ! ",  //link user, add bloc listener
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            Text(
              "Keep your information up to date to get the most of your services. You can edit your profile or make changes to your health history here.",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
            ),
            const SizedBox(height: 14),
            Text(
              "New? Add your information now to access your profile.",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14, fontWeight: FontWeight.w100),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _btnEdit(
                    title: "Edit Profile",
                    icon: UniconsLine.history,
                    backgroundcolor: Theme.of(context).colorScheme.primaryContainer,
                      onTap: () async {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileInput(email: email),
                       ),
                     );
                    }),

                _btnEdit(
                    title: "Add Disease",
                    backgroundcolor: Theme.of(context).colorScheme.tertiaryContainer,
                    icon: UniconsLine.plus,
                    onTap: () {
                      Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => InputScreen(email: userEmail),
                        ),
                      );
                    })
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      );
    }



    Widget _center() {

      Widget __helpItem({required String title}) {


        return Expanded(
          child: Column(
            children: [
              const SizedBox(height: 12),
              
              TextButton(              
                onPressed: () {  },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(                
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.black, fontSize: 14))

                  ],)

                ),
            ],
          ),
        );

    }

      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text("GET HELP WITH YOUR HEALTH",style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(

              
              // height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  __helpItem(
                    title: "Search for recommended food.",
                  ),
                  __helpItem(
                    title: "Get medication reminders.",
                  ),
                  __helpItem(
                    title: "Look up disease information.",
                  ),
                ],
              ),


            ),
            const SizedBox(height: 110),
          ],
        ),
      );
    }

    Widget _bottom() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24.0),
              padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 12,
                  bottom: 12),
              decoration: BoxDecoration(
                //color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                  ], begin: Alignment.topRight, end: Alignment.center),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    "Questions?",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 16, fontWeight: FontWeight.w100),
                  ),
                   const SizedBox(height: 4),
                  Text(
                    "Read our privacy policy and learn more about us under our SUPPORT located in your app settings.",
                    style: TextStyle(color: Theme.of(context).colorScheme.onTertiary, fontSize: 13.5),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_header(), _center(), _bottom()],
      ),
    ),
  ); 




  }
}
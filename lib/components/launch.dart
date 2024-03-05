import 'package:flutter/material.dart';
import 'package:medipal/theme/textTheme.dart';
import 'package:medipal/theme/theme.dart';
import 'package:medipal/components/menu_bar/verticalBar.dart';
import 'package:medipal/components/pages/Login/login.dart';
import 'package:medipal/components/pages/Register/register.dart';

class LaunchScreen extends StatelessWidget{
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Material(
      color: Theme.of(context).primaryColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              //MediPal LOGO IMAGE HERE (when have)
              //child: Image.asset("images/.."),
            ),
            SizedBox(height: 50), //spacing
            Text(
              "Medi-Pal",       //Logo name with theme styling
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Don't make the journey alone.",  //slogan with theme styling
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
              )
            ),
            SizedBox(height: 80),
            Column(               // login and register buttons
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginScreen(),
                          )); //navigation to login screen
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Log In",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => registerScreen(),
                          ));  //navigation to register screen
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
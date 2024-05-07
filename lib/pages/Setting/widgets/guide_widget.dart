import 'package:flutter/material.dart';


class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('APP GUIDE',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),

            RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                TextSpan(text: 'I. Profile \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Fill out your personal information and medical history for a personalized experience. \n', style: TextStyle(fontSize: 15)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 8.0)),

                TextSpan(text: 'II. Reminders \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Schedule medication reminders and always take your medication on time. \n', style: TextStyle(fontSize: 15)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 2.0)),
                TextSpan(text: '    a. Notifications:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '   Enable notifications in your app settings to turn on medication reminders. \n', style: TextStyle(fontSize: 13)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 8.0)),

                TextSpan(text: 'III. Search \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Use the search to look up foods tailored to your needs. \n', style: TextStyle(fontSize: 15)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 2.0)),
                TextSpan(text: '    a. Recipes:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '   Search for new recipes by allergies, diet, calorie count, and nutrient content. \n', style: TextStyle(fontSize: 13)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 2.0)),
                TextSpan(text: '    b. Diseases:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '   Search for approved foods for certain diseases.  \n', style: TextStyle(fontSize: 13)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 8.0)),

                TextSpan(text: 'IV. Chatbot \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Ask the chatbot questions. \n', style: TextStyle(fontSize: 15.0)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 8.0)),

                TextSpan(text: 'V. Favorites \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Save your favorite foods for later. \n', style: TextStyle(fontSize: 15.0)),
                TextSpan(text: ' \n', style: TextStyle(fontSize: 8)),

                TextSpan(text: 'VI. App Settings \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Apply any changes to reminder notifications, app theme, and user account activity in your app settings. \n', style: TextStyle(fontSize: 15)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 2.0)),
                TextSpan(text: '    a. Support:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '   Questions? Look through our support options to learn more. \n', style: TextStyle(fontSize: 13)),


              ],
              ),
            ),      
          ],
          ),

        ),

      ),

    );
  }
}



import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('PRIVACY POLICY',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),

            RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                TextSpan(text: 'Personal Data \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '   We collect various types of information when you use our app, including personal data and health-related information. This may include your name, email address, birthday, weight, height, medical history (such as diseases, allergies, etc.), as well as data related to your dietary habits, nutrient intake, and water consumption. \n', style: TextStyle(fontSize: 12.5)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 6.0)),

                TextSpan(text: '    I. Collection of Your Information \n', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '        The personal data we collect may include your name, email address, and other identifying information necessary for the functioning of the app and the services it provides. Additionally, we may collect health-related information such as your weight, height, and medical history to tailor the app features to your specific needs. \n', style: TextStyle(fontSize: 12)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 4.0)),

                TextSpan(text: '    II. How We Use Your Information \n', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '          We use the information we collect to provide you with personalized health-related services through our app. This includes organizing your medical history and dietary preferences, setting medicine reminders, suggesting diet-specific recipes, and tracking your nutrient intake. We may also use your information to improve the functionality of the app and to communicate with you about updates and new features. \n', style: TextStyle(fontSize: 12)),
                TextSpan(text: '\n', style: TextStyle(fontSize: 12.0)),

                TextSpan(text: 'Deleting Your Account \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                TextSpan(text: '   If you wish to delete your account and remove your information from our system, you can do so by following the instructions within the app. Please note that deleting your account may result in the loss of access to certain features and services provided by the app. \n', style: TextStyle(fontSize: 12.5)),

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



            // Text('PRIVACY POLICY',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 2.0),




          // child: RichText(
          //   overflow: TextOverflow.clip,
          //   text: TextSpan(
          //     text: 'PRIVACY POLICY \n',
          //     textAlign: TextAlign.center,
          //     style: DefaultTextStyle.of(context).style,
          //     //style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),


          //     children: <TextSpan>[
          //       TextSpan(text: 'Collection of Your Information \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          //       TextSpan(text: 'We collect various types of information when you use our app, including personal data and health-related information. This may include your name, email address, birthday, weight, height, medical history (such as diseases, allergies, etc.), as well as data related to your dietary habits, nutrient intake, and water consumption. \n', style: TextStyle(fontSize: 12.0)),


          //       TextSpan(text: 'Personal Data \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          //       TextSpan(text: 'The personal data we collect may include your name, email address, and other identifying information necessary for the functioning of the app and the services it provides. Additionally, we may collect health-related information such as your weight, height, and medical history to tailor the app features to your specific needs. \n', style: TextStyle(fontSize: 12.0)),


          //       TextSpan(text: 'How We Use Your Information \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          //       TextSpan(text: 'We use the information we collect to provide you with personalized health-related services through our app. This includes organizing your medical history and dietary preferences, setting medicine reminders, suggesting diet-specific recipes, and tracking your nutrient intake. We may also use your information to improve the functionality of the app and to communicate with you about updates and new features. \n', style: TextStyle(fontSize: 12.0)),


          //       TextSpan(text: 'Deleting Your Account \n', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          //       TextSpan(text: 'If you wish to delete your account and remove your information from our system, you can do so by following the instructions within the app. Please note that deleting your account may result in the loss of access to certain features and services provided by the app. \n', style: TextStyle(fontSize: 12.0)),

          //     ],


          //   ),



          // ),
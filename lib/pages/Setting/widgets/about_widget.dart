import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffffffff),
                Color(0xffe9c6d9),
              ])),

      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('ABOUT', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 25.0),

            Text("    Medi-Pal is a wellness management assistant designed to centralize your health needs by organizing your medical history & dietary preferences.\n", style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 0.5),
            Text("    Set medicine reminders, search for diet specific recipes, track your nutrient intake, and simplify your life.\n", style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 25.0),

            Text('Created By: \n Tram Bui-Vu, Alvin Jin, & Stellar Nguyen  \n 491 Senior Design, Spr. 2024', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 0.5),
          ],
        ),
      ),

    );
  }
}

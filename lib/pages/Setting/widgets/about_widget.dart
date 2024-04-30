import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('About', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),

            SizedBox(height: 30.0),
            Text("Medi-Pal is a wellness management assistant designed to centralize your health needs by organizing your medical history & dietary preferences.", style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 0.5),
            Text("Set medicine reminders, search for diet specific recipes, track nutrient intake, and more.", style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 0.5),
            Text("Simplify your life.", style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 25.0),

            Text('Created by: Tram Bui-Vu, Alvin Jin, & Stellar Nguyen for Prof. Hoffman''s'' 491 Senior Design (2024).', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 0.5),
          ],
        ),
      ),
    );
  }
}

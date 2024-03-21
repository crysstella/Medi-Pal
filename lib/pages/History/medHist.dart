import 'package:flutter/material.dart';

class MediHistory extends StatefulWidget{
  const MediHistory({super.key});

  @override
  State<MediHistory> createState() =>_MediHistoryState();
}

class _MediHistoryState extends State<MediHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Medical History')));
  }
}
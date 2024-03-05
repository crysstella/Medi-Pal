import 'package:flutter/material.dart';
import 'package:medipal/theme/textTheme.dart';
import 'package:medipal/theme/theme.dart';
//import 'package:medipal/components/SideBar/verticalBar.dart';

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
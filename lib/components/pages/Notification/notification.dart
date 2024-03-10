import 'package:flutter/material.dart';
import 'package:medipal/components/pages/Notification/localNotification.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  //LocalNotification localNotification = LocalNotification();

  /*@override init() async{
    WidgetsFlutterBinding.ensureInitialized();
    await LocalNotification.init();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Notifications'),
            TextButton(onPressed: (){
              print('show noti');
              LocalNotification.showSimpleNoti(title: 'MediPal Notification', body: 'This is MediPal notification', payload: 'MediPal data');
            }, child: Text('Local Notification'))]),
      ),
    );
  }
}

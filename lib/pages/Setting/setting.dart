import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';
import '../../blocs/log_in_bloc/log_in_bloc.dart';
import 'widgets/about_widget.dart';
import 'widgets/guide_widget.dart';
import 'widgets/privacy_widget.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "APP SETTINGS",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ).copyWith(color: Theme.of(context).colorScheme.tertiary),
                      ),
                      const SizedBox(height: 2),

                     //notifications 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextButton(
                        onPressed: () {
                          //;
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.bell),
                                Text(
                                  "Notifications",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )                                
                              ],                              
                            ),
                          ],
                        ),

                      ),
                      SizedBox(
                              height: 4,
                              child: Switch(
                                value: true,
                                onChanged: null,
                                activeTrackColor: const Color(0x9EA0A1FA),
                                //thumbColor:
                                //MaterialStateProperty.all(Colors.white),
                              ),
                            )
                      ]
                  ),
                 const SizedBox(height: 2),


                 //theme
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextButton(
                        onPressed: () {
                          //;
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.sun),
                                //Icon(UniconsLine.moon_eclipse),
                                Text(
                                  "Theme",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                      ), 
                      Text(
                       "Light Mode",
                       style: const TextStyle(
                         fontSize: 14,
                       ).copyWith(color: const Color(0x9EA0A1FA)),
                      ),
                    ]
                  ),
                  const SizedBox(height: 2),


                      //logout
                      TextButton(
                        onPressed: () {
                          context.read<LogInBloc>().add(const LogOutRequired());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.exit),
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                      ),
                      const SizedBox(height: 30),


                      Text(
                        "SUPPORT",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ).copyWith(color: Theme.of(context).colorScheme.tertiary),
                      ),
                      const SizedBox(height: 2),

                      //about
                      TextButton(
                        //style: Color(value),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const AboutPage(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.info_circle),
                                Text(
                                  "About",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),


                      //privacy policy
                      TextButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const PrivacyPage(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.clipboard_notes),
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),


                      //app guide
                      TextButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const GuidePage(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.directions),
                                Text(
                                  "App Guide",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                   const SizedBox(height: 200),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "V.1.0",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 3.3),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
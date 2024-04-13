import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';
import '../../blocs/log_in_bloc/log_in_bloc.dart';


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
                        "SETTINGS",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          height: 40 / 32,
                        ).copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        // onTap: () {
                        //  nav to Notification
                        // },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(UniconsLine.bell),
                                Text(
                                  " Notifications",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 6,
                              child: Switch(
                                value: true,
                                onChanged: null,
                                activeTrackColor: const Color(0x9EA0A1FA),
                                thumbColor:
                                MaterialStateProperty.all(Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(UniconsLine.sun),
                              Text(
                                " Theme",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Light Mode",
                                style: const TextStyle(
                                  fontSize: 14,
                                ).copyWith(color: const Color(0x9EA0A1FA)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(UniconsLine.exit),
                              Text(
                                " Log Out",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.read<LogInBloc>().add(const LogOutRequired());
                                  },
                                  icon: const Icon(
                                    UniconsLine.arrow_circle_right,
                                    color: Color(0x9EA0A1FA),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "SUPPORT",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ).copyWith(color: Theme.of(context).colorScheme.tertiary),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        // onTap: () {
                        //   nav to about info [cubit]?
                        // },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.info_circle),
                                Text(
                                  " About",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        // onTap: () {
                        //   nav to privacy policy [cubit]?
                        // },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.clipboard_notes),
                                Text(
                                  " Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        // onTap: () {
                        //   nav to app guide [cubit]?
                        // },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(UniconsLine.directions),
                                Text(
                                  " App Guide",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 350),
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
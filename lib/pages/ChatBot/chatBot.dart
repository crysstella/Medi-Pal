import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'chatBubble.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<String> messages = [];
  final List<String> topic = [
    'Diseases Information',
    'Food Recommended',
    'Food Avoided'
  ];
  String welcome = 'Hi there! How can I help you today?';
  final List<String> botResponses = [];

  @override
  void initState() {
    super.initState();
    messages.insert(0, welcome);
  }

  void onSubmitted(String text) {
    setState(() {
      messages.insert(0, welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            final message = messages[index];
            return ChatBubble(message: message.trim(), isUser: false);
          },
        )),
        Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02),
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Row(children: <Widget>[
              const Spacer(),
              IconButton(
                icon: const Icon(UniconsLine.message),
                color: Theme.of(context).primaryColor,
                splashColor: Colors.transparent,
                onPressed: () {},
              )
            ]))
      ]),
      /* Flexible(
                    child: TextField(
                      maxLines: null,
                      controller: textController,
                      onSubmitted: onSubmitted,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Type a message..."),
                    ),
                  ),*/
    ));
  }
}

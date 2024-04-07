import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<String> messages = [];
  final TextEditingController textController = TextEditingController();

  void onSubmitted(String text) {
    textController.clear();
    if (text.isNotEmpty) {
      setState(() {
        messages.insert(0, text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (_, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            style: TextStyle(color: Colors.white),
                            messages[index],
                            textAlign: TextAlign.left, // Aligns the text to the right
                          ),
                        )),
                    Icon(UniconsLine.user_circle,
                        size: 40), // Icon on the right side
                  ],
                ),
              );
            },
          ),
        ),
        Divider(height: 5.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: IconTheme(
            data:
                IconThemeData(color: Theme.of(context).primaryColor, size: 35),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: textController,
                      onSubmitted: onSubmitted,
                      decoration: InputDecoration.collapsed(
                          hintText: "Type a message..."),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: const Icon(UniconsLine.message),
                        onPressed: () => onSubmitted(textController.text)),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

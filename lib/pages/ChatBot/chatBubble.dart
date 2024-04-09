import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  //final Icon botIcon;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isUser,
    //required this.botIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Chat bubble color based on if the user is the sender or not
    final color = isUser ? const Color(0XFF857DB1) : Colors.grey[300];

    // Alignment based on if the user is the sender or not
    final axisAlign = isUser ? MainAxisAlignment.end : MainAxisAlignment.start;

    // Max width based on if the user is the sender or not
    final maxWidth = isUser
        ? MediaQuery.of(context).size.width * 0.7
        : MediaQuery.of(context).size.width * 0.6;

    return Row(mainAxisAlignment: axisAlign, children: <Widget>[
      if (!isUser) ...[
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/mascot.png'),
        ),
      ],
      Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message,
              style: TextStyle(color: isUser ? Colors.white : Colors.black87),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      )
    ]);
  }
}

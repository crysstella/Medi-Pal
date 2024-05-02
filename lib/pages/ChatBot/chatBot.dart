import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:unicons/unicons.dart';

import '../../firebase/services.dart';
import 'chatBubble.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final DataService medService = DataService(); // Firebase service
  TextEditingController typeController =
      TextEditingController(); // Control user's input
  final ScrollController scrollController =
      ScrollController(); // Control chat view
  final FocusNode _focusNode = FocusNode();
  bool isValid = false; // Check the input is valid

  final List<String> messages = [];
  final List<bool> isUser = [false];
  /*final List<String> topic = [
    'Diseases Information',
    'Food Recommended',
    'Food Avoided'
  ];*/
  String welcome = 'Hi there! How can I help you today?';
  final List<String> botResponses = [];
  static List<String> topics = ['Foods Avoided', 'Foods Recommended'];
  static List<String> diseases = [];
  static List<String> diseasesLowerCase = [];
  bool showTopics = true;
  bool showDisease = false;
  String current_topic = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    loadDiseases();
    messages.insert(0, welcome);
  }

  void loadDiseases() async {
    List<dynamic> loadedDiseases = await medService.getDiseaseName();
    setState(() {
      diseases = loadedDiseases.cast<String>();
      for (var disease in diseases) {
        diseasesLowerCase.add(disease.toLowerCase());
        print(disease.toLowerCase());
      }
    });
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      scrollToBottom();
    }
  }

  void onSubmitted(String text) {
    setState(() {
      messages.insert(0, welcome);
    });
  }

  void addMessage(String message, bool userMessage) {
    setState(() {
      messages.add(message);
      isUser.add(userMessage);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  int randomIndex(int maximum) {
    var random = Random();
    int randomIndex = random.nextInt(maximum);
    return randomIndex;
  }

  void handleDiseaseSelection(String disease) async {
    String message = '';
    print('DISEASE = $disease');
    //addMessage(disease, true); // User sends topic as a message
    try {
      print(current_topic);
      DiseaseAdvice diseaseAdvice = await medService.getDiseaseAdvice(disease);
      print('DISEASE ADVICE = $diseaseAdvice');
      if (current_topic == 'Foods Avoided') {
        var avoids = diseaseAdvice.avoidances;
        int rand = randomIndex(avoids.length);
        message = avoids[rand];
      } else if (current_topic == 'Foods Recommended') {
        var recommends = diseaseAdvice.recommendations;
        int rand = randomIndex(recommends.length);
        message = recommends[rand];
      }
      addMessage(message, false); // Bot response
    } catch (e) {
      print(e);
      addMessage('Failed to fetch data', false);
    } finally {}
  }

  // Manage the chat view to scroll to the latest chat bubble.
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  // Check the text is in the list by lower-casing all the list
  bool contains(String text, List<String> list) {
    // Convert the text to lowercase for a case-insensitive comparison
    String lowerCaseText = text.toLowerCase();

    // Check if the lower-cased text exists in the lower-cased list
    for (String item in list) {
      if (item.toLowerCase() == lowerCaseText) {
        return true; // Return true if a match is found
      }
    }
    return false; // Return false if no match is found
    //return list.contains(lowerCaseText);  // Return false if no match is found
  }

  // Transform the input text to match the list as long as it belongs to the list
  String transformText(String text) {
    text = text.toLowerCase();
    int index = diseasesLowerCase.indexOf(text);
    return diseases[index];
  }

  @override
  void dispose() {
    scrollController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // Hide keyboard when click outside the text field
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: Column(children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = messages[index];
                    return ChatBubble(
                        message: message.trim(), isUser: isUser[index]);
                  },
                )),
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10), // Add padding inside the container
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Expanded(
                    //  TextField takes the remaining space in the row
                    child: TypeAheadField<String>(
                      constraints: BoxConstraints(maxHeight: 300),
                      decorationBuilder: (context, child) {
                        return Material(
                            type: MaterialType.card,
                            elevation: 4,
                            borderRadius: BorderRadius.circular(8),
                            child: child,
                            color: Color(0xFFEEEAFD));
                      },
                      focusNode: _focusNode,
                      direction: VerticalDirection.up,
                      autoFlipDirection: true,
                      controller: typeController,
                      suggestionsCallback: (pattern) {
                        //List<String> names = await medService.getDiseaseName();
                        if (pattern.isNotEmpty) {
                          return diseases
                              .where((disease) => disease
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        } else {
                          return <String>[];
                        }
                      },
                      builder: (context, controller, focusNode) => TextField(
                        controller: typeController,
                        enabled: !showTopics,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: !showTopics
                              ? 'Type a message...'
                              : 'Pick topics...', // Placeholder text
                          border: InputBorder.none, // Removes underline
                          isDense: true,
                          suffixIcon: IconButton(
                            iconSize: 25,
                            icon: const Icon(UniconsLine.message),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              // Send button action by text controller
                              String text = typeController.text.trim();
                              if (text.isNotEmpty &&
                                  contains(text, diseasesLowerCase)) {
                                addMessage(text, true);
                                typeController
                                    .clear(); // Clear text field after sending
                                handleDiseaseSelection(transformText(text));
                              }
                              _focusNode
                                  .requestFocus(); // keep the focus on text field.
                            },
                          ), // Adds vertical constraints
                        ),
                        // Press enter
                        onSubmitted: (value) {
                          // Handle message sending
                          String diseaseInput = value.trim();
                          if (diseaseInput.isNotEmpty &&
                              contains(diseaseInput, diseasesLowerCase)) {
                            addMessage(diseaseInput, true);
                            handleDiseaseSelection(transformText(diseaseInput));
                            typeController
                                .clear(); // Clear text field after sending
                          }
                          _focusNode
                              .requestFocus(); // keep the focus on text field.
                        },
                      ),
                      onSelected: (diseaseName) {
                        typeController.text = diseaseName.trim();
                        typeController.selection = TextSelection.fromPosition(
                          TextPosition(offset: typeController.text.length),
                        );
                      },
                      itemBuilder: (context, diseaseName) {
                        return ListTile(
                            title: Text(
                          diseaseName,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ));
                      },
                      emptyBuilder: (context) {
                        if (typeController.text.isNotEmpty) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'No Items Found!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ));
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ),
                if (showTopics)
                  Column(
                    children: topics.map((topic) {
                      bool isLast = topics.last == topic;
                      return Padding(
                        padding: EdgeInsets.symmetric() +
                            EdgeInsets.only(bottom: isLast ? 10.0 : 0),
                        child: ActionChip(
                          label: Text(topic),
                          onPressed: () {
                            print("Selected topic: $topic");
                            addMessage(
                                topic, true); // User sends topic as a message
                            addMessage('Which disease you want to know?',
                                false); // Bot responds
                            setState(() {
                              current_topic = topic;
                              showTopics = false;
                              showDisease = true;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                /* if (showDisease)
                  Column(
                    children: diseases.map((disease) {
                      bool isLast = diseases.last == disease;
                      return Padding(
                        padding: EdgeInsets.symmetric() +
                            EdgeInsets.only(bottom: isLast ? 10.0 : 0),
                        child: ActionChip(
                          label: Text(disease),
                          onPressed: () => handleDiseaseSelection(disease),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),*/
              ]),
            )));
  }
}

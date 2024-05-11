import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:unicons/unicons.dart';
import '../../firebase/services.dart';
import '../../shared_preferences.dart';

class DiseaseSearch extends StatefulWidget {
  const DiseaseSearch({super.key});

  @override
  State<DiseaseSearch> createState() => _DiseaseSearchState();
}

class _DiseaseSearchState extends State<DiseaseSearch> {
  DataService foodService = DataService();
  //List<String> favoriteFoods = [];
  //String? _selectedFood;

  final TextEditingController _searchEditingController =
      TextEditingController();
  bool _isLoading = false;
  List<String> _searchResults = [];
  List<String> diseases = [];
  String errorMessage = '';
  String userInput = '';
  bool isSearchPressed = false;

  @override
  void initState() {
    super.initState();
    loadDiseases();
    errorMessage = ' ';
    isSearchPressed = false;
  }

  // Compare two string ignore case sensitivity
  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  // Check if disease in diseases list
  bool isInListIgnoreCase(String disease, List<String> list) {
    // Convert the value to lowercase
    String lowerDisease = disease.toLowerCase();

    // Use any() method to check if the list contains the value, ignoring case
    return list.any((item) => item.toLowerCase() == lowerDisease);
  }

  // Get diseases list from foodDatabase
  void loadDiseases() async {
    List<dynamic> loadedDiseases =
        await foodService.getDiseasesInFoodDatabase();
    setState(() {
      // Get diseases suggestion from database
      diseases = loadedDiseases.cast<String>();
      print('Diseases = ${diseases}');
    });
  }

  void showInvalidMessage(BuildContext context) {
    setState(() {
      _searchResults = [];
      errorMessage = "Error Loading...";
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: const Text('Invalid input'),
      duration: const Duration(seconds: 2),
    ));
  }

  Widget buildSearchResults(List<String> searchResults) {
    return (_searchResults.isNotEmpty)
        ? Expanded(
            child: ListView.builder(
                // padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  print('THIS IS IN BUILD SEARCH RESULTS:');
                  print(searchResults);
                  return Card(
                      child: ListTile(
                    title: Text(searchResults[index]),
                  ));
                }))
        : Expanded(
            child: SizedBox(
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      isSearchPressed
                          ? const Icon(
                              UniconsLine.exclamation_triangle,
                              size: 50,
                              color: Colors.red,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        errorMessage,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ])));
  }

  Future<void> handleInputDisease(String disease) async {
    print('HANDLE INPUT DISEASE');
    _searchResults = [];

    if (isInListIgnoreCase(disease, diseases)) {
      setState(() {
        _isLoading = true;
      });
      try {
        List<dynamic> foods = await foodService.getFoodsByDisease(disease);
        if (foods.isNotEmpty) {
          print('FOODS IS NOT EMPTY');
          setState(() {
            _isLoading = false;
            _searchResults = foods.cast<String>();
          });
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        errorMessage = 'No results found for your input.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: const BoxDecoration(
          color: Color(0xFFEEEAFD),
        ),
        child: Expanded(
          child: TypeAheadField<String>(
              controller: _searchEditingController,
              constraints: const BoxConstraints(maxHeight: 300),
              suggestionsCallback: (pattern) {
                if (pattern.isNotEmpty) {
                  return diseases
                      .where((disease) =>
                          disease.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                  return <String>[];
                }
              },
              builder: (context, controller, focusNode) => TextField(
                    focusNode: focusNode,
                    controller: _searchEditingController,
                    onChanged: (textEntered) {
                      setState(() {
                        errorMessage = ' ';
                        userInput = textEntered;
                      });
                    },
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search diseases for food recommendations...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          icon: Icon(UniconsLine.search,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            String disease =
                                _searchEditingController.text.trim();
                            setState(() {
                              isSearchPressed = true;
                            });
                            if (disease.isNotEmpty) {
                              print('TYPE: ${disease}');
                              print('BEFORE CALL HANDLE INPUT DISEASE');
                              setState(() {
                                userInput = disease;
                              });
                              handleInputDisease(disease);
                              _searchEditingController.clear();
                            } else {
                              setState(() {
                                userInput = '';
                              });
                              showInvalidMessage(context);
                            }
                          }),
                    ),
                    onSubmitted: (disease) {
                      FocusScope.of(context).unfocus();
                      String disease = _searchEditingController.text.trim();
                      setState(() {
                        isSearchPressed = true;
                      });
                      if (disease.isNotEmpty) {
                        print('TYPE: ${disease}');
                        setState(() {
                          userInput = disease;
                        });
                        handleInputDisease(disease);
                        _searchEditingController.clear();
                      } else {
                        setState(() {
                          userInput = '';
                        });
                        showInvalidMessage(context);
                      }
                    },
                  ),
              onSelected: (diseaseName) {
                _searchEditingController.text = diseaseName.trim();
                _searchEditingController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _searchEditingController.text.length),
                );
              },
              itemBuilder: (context, diseaseName) {
                return ListTile(
                    title: Text(
                  diseaseName,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ));
              },
              hideOnEmpty: false,
              emptyBuilder: (context) {
                if (_searchEditingController.text.isNotEmpty) {
                  return Container(
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        'No Items Found!',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      ));
                }
                return const SizedBox();
              }),
        ),
      ),
      const SizedBox(height: 10),
      isSearchPressed ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show results:'),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEAFD),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 35,
            child: Text(
              userInput,
            ),
          )),
        ],
      ): const SizedBox(),
      const SizedBox(height: 5),
      _isLoading
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Center(
                  child: Icon(UniconsLine.spinner_alt,
                      color: Theme.of(context).primaryColor, size: 30.0)),
            )
          : buildSearchResults(_searchResults),
    ]);
  }
}

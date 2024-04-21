import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

<<<<<<< HEAD
class MedicineFormHelper {
  static List<DoseForm> forms = [
    DoseForm(name: "Tablet", icon: UniconsLine.tablets),
    DoseForm(name: "Capsule", icon: UniconsLine.capsule),
  ];

  static IconData getIconByDose(String name) {
    for (var form in forms) {
      if (form.name.toLowerCase() == name.toLowerCase()) {
        return form.icon;  // Return IconData directly
      }
    }
    // Return a default icon if no match is found
    return UniconsLine.prescription_bottle; // Example default icon
  }
}

=======
>>>>>>> 9be9239 (adding dose feature, handle tap notification in startApp.dart.)
class DoseForm {
  final String name;
  final IconData icon;

  DoseForm({required this.name, required this.icon});
}

class DoseFormSelector extends StatefulWidget {
  final ValueNotifier<String> doseFormNotifier;
  final Function(String) onDoseFormChanged;
  final GlobalKey<_DoseFormSelectorState> doseFormSelectorKey = GlobalKey();

  DoseFormSelector({required this.doseFormNotifier, required this.onDoseFormChanged});

  @override
  _DoseFormSelectorState createState() => _DoseFormSelectorState();
}

class _DoseFormSelectorState extends State<DoseFormSelector> {
  int? selectedIndex;
  bool isExpanded = false;

<<<<<<< HEAD
=======
  List<DoseForm> forms = [
    DoseForm(name: "Tablet", icon: UniconsLine.tablets),
    DoseForm(name: "Capsule", icon: UniconsLine.capsule),
    // Add more forms as needed
  ];

>>>>>>> 9be9239 (adding dose feature, handle tap notification in startApp.dart.)
  void handleDoseFormChanged(String doseForm){
    widget.onDoseFormChanged(doseForm);
  }

  @override
  void dispose() {
    widget.doseFormNotifier.dispose();
    super.dispose();
  }

  Widget showDosePicker(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
<<<<<<< HEAD
        children: List<Widget>.generate(MedicineFormHelper.forms.length, (index) {
=======
        children: List<Widget>.generate(forms.length, (index) {
>>>>>>> 9be9239 (adding dose feature, handle tap notification in startApp.dart.)
          return InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
<<<<<<< HEAD
                String selectedDoseForm = MedicineFormHelper.forms[index].name;
=======
                String selectedDoseForm = forms[index].name;
>>>>>>> 9be9239 (adding dose feature, handle tap notification in startApp.dart.)
                handleDoseFormChanged(selectedDoseForm);
                widget.doseFormNotifier.value = selectedDoseForm;
              },
              child: Card(
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
<<<<<<< HEAD
                      Icon(MedicineFormHelper.forms[index].icon,
=======
                      Icon(forms[index].icon,
>>>>>>> 9be9239 (adding dose feature, handle tap notification in startApp.dart.)
                          size: 40,
                          color: selectedIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
<<<<<<< HEAD
                          MedicineFormHelper.forms[index].name,
=======
                          forms[index].name,
>>>>>>> 9be9239 (adding dose feature, handle tap notification in startApp.dart.)
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: const Text(
        'Dose Form',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      trailing: ValueListenableBuilder<String>(
        valueListenable: widget.doseFormNotifier,
        builder: (context, value, child) {
          return Text(
            value,
            style: const TextStyle(fontSize: 16),
          );
        },
      ),
      children: <Widget>[
        showDosePicker(context),
        const SizedBox(height: 10.0)
      ],
    );
  }
}

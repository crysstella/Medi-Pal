import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

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
        children: List<Widget>.generate(MedicineFormHelper.forms.length, (index) {
          return InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                String selectedDoseForm = MedicineFormHelper.forms[index].name;
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
                      Icon(MedicineFormHelper.forms[index].icon,
                          size: 40,
                          color: selectedIndex == index
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          MedicineFormHelper.forms[index].name,
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

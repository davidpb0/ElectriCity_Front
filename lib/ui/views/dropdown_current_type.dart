import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownCurrentType extends StatefulWidget {

  late final Function catchValue;
  DropdownCurrentType({super.key, required this.catchValue});

  @override
  State<DropdownCurrentType> createState() => _DropdownCurrentTypeState();
  String value = "None";

}

class _DropdownCurrentTypeState extends State<DropdownCurrentType> {
  String selectedValue = "None";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "None", child: Text("None", style: TextStyle(color: Colors.black),)),
      const DropdownMenuItem(value: "AC", child: Text("AC", style: TextStyle(color: Colors.black),)),
      const DropdownMenuItem(value: "DC", child: Text("DC", style: TextStyle(color: Colors.black),)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
          return DropdownButton(
            iconEnabledColor: Colors.black,
            dropdownColor: Colors.green,
            onChanged: (String? newValue) {
              selectedValue = newValue!;
              setState(() {
                selectedValue;
                widget.catchValue(selectedValue);
              });
            },
            value: selectedValue,
            items: dropdownItems,
          );
        }
    );
  }
}

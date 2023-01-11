import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownSpeedType extends StatefulWidget {

  late final Function catchValue;
  DropdownSpeedType({super.key, required this.catchValue});

  @override
  State<DropdownSpeedType> createState() => _DropdownSpeedTypeState();
  String value = "None";

}

class _DropdownSpeedTypeState extends State<DropdownSpeedType> {
  String selectedValue = "None";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "None", child: Text("Speed", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "RAPID", child: Text("RAPID", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "semiRAPID", child: Text("semiRAPID", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "NORMAL", child: Text("NORMAL", style: TextStyle(color: Colors.black, fontSize: 15),)),
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

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownConnectionType extends StatefulWidget {

  late final Function catchValue;
  DropdownConnectionType({super.key, required this.catchValue});

  @override
  State<DropdownConnectionType> createState() => _DropdownConnectionTypeState();
  String value = "None";

}

class _DropdownConnectionTypeState extends State<DropdownConnectionType> {
  String selectedValue = "None";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "None", child: Text("Connection", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "MENNEKES", child: Text("MENNEKES", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "MENNEKES.F", child: Text("MENNEKES.F", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "MENNEKES.TESLA", child: Text("MENNEKES.TESLA", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "TESLA", child: Text("TESLA", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "CSS Combo2", child: Text("CSS Combo2", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "Schuko", child: Text("Schuko", style: TextStyle(color: Colors.black, fontSize: 15),)),
      const DropdownMenuItem(value: "ChadeMO", child: Text("ChadeMO", style: TextStyle(color: Colors.black, fontSize: 15),)),
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

import 'package:flutter/material.dart';

class DropdownItem extends StatefulWidget {

  const DropdownItem({super.key});

  @override
  State<DropdownItem> createState() => _DropdownItemState();

}

class _DropdownItemState extends State<DropdownItem> {
  String selectedValue = "0";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "0", child: Text("0")),
      const DropdownMenuItem(value: "1", child: Text("1")),
      const DropdownMenuItem(value: "2", child: Text("2")),
      const DropdownMenuItem(value: "3", child: Text("3")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedValue,
        dropdownColor: Colors.green,
        onChanged: (String? newValue){
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: dropdownItems
    );
  }
}

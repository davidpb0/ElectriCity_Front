import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownItem extends StatefulWidget {

  late final Function catchValue;
  DropdownItem({super.key, required this.catchValue});

  @override
  State<DropdownItem> createState() => _DropdownItemState();
  //el valor que quiero cojer desde routepage
  String value = "0";

}

class _DropdownItemState extends State<DropdownItem> {
  String selectedValue = "0";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "0", child: Text("0", style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: "1", child: Text("1", style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: "2", child: Text("2", style: TextStyle(color: Colors.white),)),
      const DropdownMenuItem(value: "3", child: Text("3", style: TextStyle(color: Colors.white),)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton(
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.green,
          onChanged: (String? newValue) {
            selectedValue = newValue!;
            setState(() {
              selectedValue;
              //seteo el valor que quiero cojer desde routepage
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

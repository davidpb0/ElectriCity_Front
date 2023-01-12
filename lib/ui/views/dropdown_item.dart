import 'package:flutter/material.dart';

import '../../core/controllers/cosmetics_controller.dart';

// ignore: must_be_immutable
class DropdownItem extends StatefulWidget {

  late final Function catchValue;
  DropdownItem({super.key, required this.catchValue});

  @override
  State<DropdownItem> createState() => _DropdownItemState();
  String value = "0";

}

class _DropdownItemState extends State<DropdownItem> {
  String selectedValue = "0";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "0", child: Text("0", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),)),
      DropdownMenuItem(value: "1", child: Text("1", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),)),
      DropdownMenuItem(value: "2", child: Text("2", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),)),
      DropdownMenuItem(value: "3", child: Text("3", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolorlight)),)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton(
          iconEnabledColor: Color(CosmeticsController().getCurrentTheme().textcolorlight),
          dropdownColor: Color(CosmeticsController().getCurrentTheme().accentcolor),
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

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/controllers/cosmetics_controller.dart';

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
      DropdownMenuItem(value: "None", child: Text(AppLocalizations.of(context).filtercharger_speed, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "RAPID", child: Text("RAPID", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "semiRAPID", child: Text("semiRAPID", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "NORMAL", child: Text("NORMAL", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
          return DropdownButton(
            iconEnabledColor: Color(CosmeticsController().getCurrentTheme().textcolordark),
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

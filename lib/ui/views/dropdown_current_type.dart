import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  CosmeticsController cosmeticsController = CosmeticsController();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "None", child: Text(AppLocalizations.of(context).filtercharger_current, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "AC", child: Text("AC", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15))),
      DropdownMenuItem(value: "DC", child: Text("DC", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15))),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) {
          return DropdownButton(
            iconEnabledColor: Color(cosmeticsController.getCurrentTheme().textcolordark),
            dropdownColor: Color(cosmeticsController.getCurrentTheme().accentcolor),
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

import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class DropdownConnectionType extends StatefulWidget {

  late final Function catchValue;
  DropdownConnectionType({super.key, required this.catchValue});

  @override
  State<DropdownConnectionType> createState() => _DropdownConnectionTypeState();
  String value = "None";

}

class _DropdownConnectionTypeState extends State<DropdownConnectionType> {
  CosmeticsController cosmeticsController = CosmeticsController();
  String selectedValue = "None";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "None", child: Text(AppLocalizations.of(context).filtercharger_connection, style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "MENNEKES", child: Text("MENNEKES", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "MENNEKES.F", child: Text("MENNEKES.F", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "MENNEKES.TESLA", child: Text("MENNEKES.TESLA", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "TESLA", child: Text("TESLA", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "CSS Combo2", child: Text("CSS Combo2", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "Schuko", child: Text("Schuko", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
      DropdownMenuItem(value: "ChadeMO", child: Text("ChadeMO", style: TextStyle(color: Color(CosmeticsController().getCurrentTheme().textcolordark), fontSize: 15),)),
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

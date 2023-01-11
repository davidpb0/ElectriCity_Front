import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderLoginComponent extends StatelessWidget {
  const HeaderLoginComponent({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;


  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    return SizedBox(
      // Cubrira el 20% del total de la altura
      height: size.height * 0.3,
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 83,
            top: size.height * 0.1
          ),
          height: size.height * 0.3 - 27,
          decoration: BoxDecoration(
              color: Color(cosmeticsController.getCurrentTheme().accentcolor),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(36),
                  bottomLeft: Radius.circular(36)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 10,
                ),
              ]),
          child: Row(
            children: <Widget>[
              Column(
                children:  [
                  Text(
                    "ElectriCity",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).login_welcomeback,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: -5,
          left: 170,
          right: 0,
          child: SizedBox(
            height: 110,
            child: Image.asset(
              'assets/images/title_logo_car.png',
              fit: BoxFit.contain,
              height: 100,
            ),
          )
        ),
      ]),
    );
  }
}

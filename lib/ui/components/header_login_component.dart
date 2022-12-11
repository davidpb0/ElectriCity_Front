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
    return SizedBox(
      // Cubrira el 20% del total de la altura
      height: size.height * 0.2,
      child: Stack(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 83,
          ),
          height: size.height * 0.2 - 27,
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(36),
                  bottomLeft: Radius.circular(36)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 10,
                ),
              ]),
          child: Row(
            children: <Widget>[
              Column(
                children:  [
                  const Text(
                    "ElectriCity",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).login_welcomeback,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
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

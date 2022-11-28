import 'package:flutter/material.dart';

class DefaultHeader extends StatelessWidget implements PreferredSizeWidget{
  const DefaultHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.only(top: 24),
          height: size.height,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "ElectriCity",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(
                  'assets/images/title_logo_car.png',
                  fit: BoxFit.contain,
                  height: 36,
                ),
              ),
            ],
          ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => size;


}

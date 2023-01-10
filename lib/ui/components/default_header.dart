import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';

class DefaultHeader extends StatelessWidget implements PreferredSizeWidget {
  const DefaultHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    CosmeticsController _cc = CosmeticsController();
    return Container(
      padding: const EdgeInsets.only(top: 24),
      height: size.height,
      decoration: BoxDecoration(
          color: Color(_cc.getCurrentTheme().accentcolor),
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
  Size get preferredSize => size;
}

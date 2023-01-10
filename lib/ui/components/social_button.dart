import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialMedia { facebook, twitter }

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onClicked;

  const SocialButton(
      {super.key, required this.icon, this.color, required this.onClicked});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Center(
          child: FaIcon(
            icon,
            color: color,
            size: 40,
          ),
        ),
      ),
    );
  }
}

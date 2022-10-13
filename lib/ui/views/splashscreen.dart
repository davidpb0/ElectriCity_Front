import 'package:electricity_front/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreen extends StatelessWidget{
  const SplashScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/animations/splashscreenanimation.json'),
      splashIconSize: 250,
      backgroundColor: const Color(0xFFEEEEEE),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft ,
      nextScreen: const MyHomePage(title: 'Home',),
    );
  }

}
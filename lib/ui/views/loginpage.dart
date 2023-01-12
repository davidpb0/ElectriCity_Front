import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/header_login_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController _passwdTextController = TextEditingController();
  final UserController userCtrl = UserController();
  final CosmeticsController cosmeticsController = CosmeticsController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
        /*appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
        ),*/
        body: Column(
          children: <Widget>[
            HeaderLoginComponent(size: size),

            const SizedBox(height: 40),
            //Username textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 1,
                    ),
                  ],
                  color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                  border: Border.all(color: Color(cosmeticsController.getCurrentTheme().elementcolordark)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextField(
                    controller: emailTextController,
                    style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Color(cosmeticsController.getCurrentTheme().textcolordark),),
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark))
                    ),
                  ),
                ),
              ),
            ),

            //Password textfield
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 1,
                    ),
                  ],
                  color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                  border: Border.all(color: Color(cosmeticsController.getCurrentTheme().elementcolordark)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextField(
                    controller: _passwdTextController,
                    obscureText: true,
                    style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Color(cosmeticsController.getCurrentTheme().textcolordark),),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).signup_password,
                      hintStyle: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark))
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            //Forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${AppLocalizations.of(context).login_forgotpassword} ", style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),) ,
                Text(
                  AppLocalizations.of(context).login_clickhere,
                  style:  TextStyle(
                      color: Color(cosmeticsController.getCurrentTheme().accentcoloralt),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 50),

            //SignIn Botton

            SizedBox(
              height: 80,
              width: 200,
              child: TextButton(
                onPressed: () {
                  //CAMBIO A MAPA FAST (SIN API)
                  userCtrl.startSession(emailTextController.text,
                      _passwdTextController.text, context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 5,
                        ),
                      ],
                      color: Color(cosmeticsController.getCurrentTheme().accentcolor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Text(
                          AppLocalizations.of(context).login_signin,
                          style: TextStyle(
                            color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            //const SizedBox(height: 30),
            const SizedBox(height: 40),
            //SignUp
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context).login_notamember, style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),),
                SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signup');
                    },
                    child: Text(AppLocalizations.of(context).login_signup,
                        style: TextStyle(
                            color: Color(cosmeticsController.getCurrentTheme().accentcoloralt),
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
}


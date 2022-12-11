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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
        ),
        body: Body());
  }
}

class Body extends StatelessWidget {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController _passwdTextController = TextEditingController();
  final UserController userCtrl = UserController();

  Body({super.key});

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size size = MediaQuery.of(context).size;
    return Column(
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
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                  hintText: 'Email',
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
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: TextField(
                controller: _passwdTextController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context).signup_password,
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
            Text("${AppLocalizations.of(context).login_forgotpassword} ") ,
            Text(
              AppLocalizations.of(context).login_clickhere,
              style: const TextStyle(
                  color: Colors.indigoAccent, fontWeight: FontWeight.bold),
            )
          ],
        ),
        //const SizedBox(height: 50),

        //SigIn Botton
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
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).login_signin,
                    style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
              ),
            ),
          ),
        ),
        //const SizedBox(height: 30),

        //Sign with
        Text(AppLocalizations.of(context).login_signinwith),

        //Google botton
        SizedBox(
          width: 100,
          height: 100,
          child: TextButton(
              onPressed: () {
                //Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 5,
                      )
                    ],
                    color: Color(0xFFEEEEEE),
                  ),
                  child: Center(
                      child: Image.asset('assets/images/googleIcon.png')),
                ),
              )
          ),
        ),

        const SizedBox(height: 40),
        //SignUp
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context).login_notamember),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: Text(AppLocalizations.of(context).login_signup,
                    style: const TextStyle(
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

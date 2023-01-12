import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/controllers/signup_controller.dart';
import '../../core/controllers/user_controller.dart';
import '../components/header_login_component.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final TextEditingController _passwdTextController = TextEditingController();
  final TextEditingController _passwdValidTextController =
      TextEditingController();
  SignupController signupCtrl = SignupController();
  UserController userCtrl = UserController();
  CosmeticsController cosmeticsController = CosmeticsController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
      body: Column(children: <Widget>[
        Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
          HeaderLoginComponent(size: size),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              icon: Icon(
                Icons.arrow_back,
                size: 24,
                color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
              )
          )
        ]),
        Expanded(
          child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
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
                        child: TextFormField(
                          controller: usernameTextController,
                          style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                          decoration:  InputDecoration(
                            prefixIcon: Icon(Icons.account_circle, color: Color(cosmeticsController.getCurrentTheme().textcolordark),),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).signup_username,
                            hintStyle: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark))
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).signup_emptyfield;
                            }
                            if (signupCtrl.usernameError() != '') {
                              return signupCtrl.usernameError();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  //Email textfield
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
                        child: TextFormField(
                          controller: emailTextController,
                          style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Color(cosmeticsController.getCurrentTheme().textcolordark),),
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark))
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).signup_emptyfield;
                            }
                            if (signupCtrl.emailError() != '') {
                              return signupCtrl.emailError();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  //Password textfield
                  const SizedBox(height: 16),
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
                        child: TextFormField(
                          controller: _passwdTextController,
                          obscureText: true,
                          style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Color(cosmeticsController.getCurrentTheme().textcolordark),),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).signup_password,
                            hintStyle: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark))
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).signup_emptyfield;
                            }
                            if (signupCtrl.pwdError() != '') {
                              return signupCtrl.pwdError();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  //Repeat password textfield
                  const SizedBox(height: 16),
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
                        child: TextFormField(
                          controller: _passwdValidTextController,
                          obscureText: true,
                          style: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Color(cosmeticsController.getCurrentTheme().textcolordark),),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).signup_repeatpassword,
                            hintStyle: TextStyle(color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                            errorText: signupCtrl.pwdError(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).signup_emptyfield;
                            }
                            if (signupCtrl.pwdError() != '') {
                              return signupCtrl.pwdError();
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  //Create account Button
                  SizedBox(
                    height: 80,
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        //Navigator.of(context).pushReplacementNamed('/home');
                        signupCtrl.setUsername(usernameTextController.text);
                        signupCtrl.setEmail(emailTextController.text);
                        signupCtrl.setPasswd(_passwdTextController.text);
                        signupCtrl
                            .setPasswdRepeat(_passwdValidTextController.text);
                        if (signupCtrl.validatePassword()) {
                          signupCtrl.signUp(emailTextController.text,
                              _passwdTextController.text, context);
                        }

                        _formKey.currentState!.validate();

                        //signupCtrl.printData();
                        //signupCtrl.signUp(context);
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
                          child:  Center(
                            child: Text(
                              AppLocalizations.of(context).signup_createaccount,
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
                ],
              )
          ),
        ),
      ]),
    );
  }
}

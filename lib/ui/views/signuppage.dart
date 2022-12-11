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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Da la altura y el ancho total de la pantalla
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Column(children: <Widget>[
        Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
          HeaderLoginComponent(size: size),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.white,
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
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: usernameTextController,
                          decoration:  InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).signup_username,
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: emailTextController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _passwdTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).signup_password,
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _passwdValidTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).signup_repeatpassword,
                            errorText: signupCtrl.pwdError(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child:  Center(
                            child: Text(
                              AppLocalizations.of(context).signup_createaccount,
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
                ],
              )
          ),
        ),
      ]),
    );
  }
}

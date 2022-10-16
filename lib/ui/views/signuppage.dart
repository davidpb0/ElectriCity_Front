
import 'package:flutter/material.dart';

import '../../core/controllers/signupController.dart';
import '../components/header_login_component.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();

}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
        ),
        body: Body()
    );
  }
}

class Body extends StatelessWidget{
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController _passwdTextController = TextEditingController();
  TextEditingController _passwdValidTextController = TextEditingController();
  SignupController signupCtrl = SignupController();

  @override
  Widget build(BuildContext context){
    //Da la altura y el ancho total de la pantalla
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        HeaderLoginComponent(size: size),

        SizedBox(height: 40),
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
              padding: EdgeInsets.only(left: 5.0),
              child: TextField(
                controller: usernameTextController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  border: InputBorder.none,
                  hintText: 'Username',

                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 16),
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
              padding: EdgeInsets.only(left: 5.0),
              child: TextField(
                controller: emailTextController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                  hintText: 'Email',

                ),
              ),
            ),
          ),
        ),

        //Password textfield
        SizedBox(height: 16),
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
              padding: EdgeInsets.only(left: 5.0),
              child: TextField(
                controller: _passwdTextController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
          ),
        ),

        //Repeat password textfield
        SizedBox(height: 16),
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
              padding: EdgeInsets.only(left: 5.0),
              child: TextField(
                controller: _passwdValidTextController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                  hintText: 'Repeat password',
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 40),

        //Create account Button
        SizedBox(
          height: 80,
          width: 200,
          child: TextButton(
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/home');
              signupCtrl.setUsername( usernameTextController.text);
              signupCtrl.setEmail( emailTextController.text);
              signupCtrl.setPasswd(_passwdTextController.text, _passwdValidTextController.text);
              signupCtrl.printData();
            },

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                  color:  Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


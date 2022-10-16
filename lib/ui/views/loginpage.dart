import 'package:electricity_front/core/controllers/loginController.dart';
import 'package:flutter/material.dart';

import '../components/header_login_component.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
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
  TextEditingController emailTextController = TextEditingController();
  TextEditingController _passwdTextController = TextEditingController();
  LoginController loginCtrl = LoginController();

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
        SizedBox(height: 10),
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
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),

        //Forget password
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Forgot password?"),
            Text(
              ' Click here',
              style: TextStyle(
                  color: Colors.indigoAccent,
                  fontWeight: FontWeight.bold
              ),
            )

          ],
        ),
        const SizedBox(height: 50),



        //SigIn Botton
        SizedBox(
          height: 80,
          width: 200,
          child: TextButton(
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/home');
              loginCtrl.setEmail( emailTextController.text);
              loginCtrl.setPasswd(_passwdTextController.text);
              loginCtrl.printData();
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
                        'Sign In',
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
        const SizedBox(height: 30),

        //Sign with
        Text('Sign with:'),

        //Google botton
        SizedBox(
          width: 100,
          height: 100,
          child: TextButton(
              onPressed: (){
                //Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  padding: EdgeInsets.all(10),
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
                      child: Container(
                        child: Image.asset('assets/images/googleIcon.png'),
                      )
                  ),

                ),
              )
          ),
        ),

        const SizedBox(height: 40),
        //SignUp
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Not a member?'),
            SizedBox(
              child: TextButton(
                onPressed:(){
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: Container(
                  child: const Text('Sign up',
                    style: TextStyle(
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),
            )
          ],
        ),


      ],
    );
  }
}


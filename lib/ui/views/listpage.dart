import 'package:electricity_front/ui/components/list_item_component.dart';
import 'package:flutter/material.dart';

import '../../core/controllers/signupController.dart';
import '../components/header_login_component.dart';

class ListPage extends StatefulWidget{
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();

}

class _ListPageState extends State<ListPage> {
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
    return  Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
        title: const Text("ElectriCity"),
        ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return ListItemComponent();
          },

        )
      );
  }
}


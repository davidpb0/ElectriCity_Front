import 'dart:core';
import 'package:electricity_front/core/controllers/mapaController.dart';
import 'package:flutter/material.dart';

class InfoPersonalUbiForm extends StatelessWidget{
   InfoPersonalUbiForm();

  TextEditingController telefTextController = TextEditingController();
  TextEditingController adressTextController = TextEditingController();
  TextEditingController titolTextController = TextEditingController();






   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
          children: [
            Container(
            height: 500,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1,

                )],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
            ),
            child: Column(children: [
              SizedBox(height: 150),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    color: Colors.yellow
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Afegeix una nova ubicació personal",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                  color: Colors.white,
                  child: Column(
                    //padding
                    children: [
                      TextField(
                            controller: titolTextController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.maps_home_work),
                                border: InputBorder.none,
                                hintText: "Títol"
                            ),
                          ),
                      TextField(
                        controller: telefTextController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: InputBorder.none,
                            hintText: "Descripció"
                        ),
                      ),
                      SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: 130,
                    child: TextButton(
                      onPressed: (){
                        //CAMBIO A MAPA FAST (SIN API)
                        //Navigator.of(context).pushReplacementNamed('/home');
                        MapaController().personalUbi(titolTextController.text,  telefTextController.text, context);

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
                            color:  Colors.yellow,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                              child: Text(
                                'Add location',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                    ],
                  )),
            ]),
          ),
        ],
        ),
      ),
    );
  }

}


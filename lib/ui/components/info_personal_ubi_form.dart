import 'dart:core';
import 'package:electricity_front/core/controllers/mapaController.dart';
import 'package:flutter/material.dart';

class InfoPersonalUbiForm extends StatelessWidget {
  InfoPersonalUbiForm();

  TextEditingController telefTextController = TextEditingController();
  TextEditingController adressTextController = TextEditingController();
  TextEditingController titolTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: Text(
          "Add a personal location",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(children: [
                SizedBox(height: 80, width: 500),
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Text(
                        "Add a title to your location:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 1,
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 350,
                  child: TextField(
                    controller: titolTextController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.maps_home_work),
                        border: InputBorder.none,
                        hintText: "Title"),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Text(
                        "Add a description to your location:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 1,
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 350,
                  child: TextField(
                    controller: telefTextController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        border: InputBorder.none,
                        hintText: "Description"),
                  ),
                ),
                SizedBox(height: 60),
                SizedBox(
                  height: 80,
                  width: 180,
                  child: TextButton(
                    onPressed: () {
                      //CAMBIO A MAPA FAST (SIN API)
                      //Navigator.of(context).pushReplacementNamed('/home');
                      MapaController().personalUbi(titolTextController.text,
                          telefTextController.text, context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 5,
                            ),
                          ],
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                            child: Text(
                          'Add location',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 80),
            Row(
              children: [
                SizedBox(width: (MediaQuery.of(context).size.width / 2) - 65),
                Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/add_location.png',
                    fit: BoxFit.contain,
                    height: 150,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

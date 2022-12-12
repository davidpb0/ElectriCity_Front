import 'dart:core';
import 'package:electricity_front/core/controllers/mapa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPersonalUbiForm extends StatelessWidget {
  InfoPersonalUbiForm({super.key});

  final TextEditingController telefTextController = TextEditingController();
  final TextEditingController adressTextController = TextEditingController();
  final TextEditingController titolTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: Text(
          AppLocalizations.of(context).personallocation_header,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              const SizedBox(height: 80, width: 500),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Text(
                    AppLocalizations.of(context).personallocation_addtitle,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                      prefixIcon: const Icon(Icons.maps_home_work),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).personallocation_title),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children:  [
                  const SizedBox(width: 25),
                  Text(
                    AppLocalizations.of(context).personallocation_adddescription,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                  decoration:  InputDecoration(
                      prefixIcon: const Icon(Icons.location_on),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).personallocation_description),
                ),
              ),
              const SizedBox(height: 60),
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
                      padding: const EdgeInsets.all(10),
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
                      child:  Center(
                          child: Text(
                            AppLocalizations.of(context).personallocation_submit,
                        style: const TextStyle(
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
            const SizedBox(height: 40),
            Row(
              children: [
                SizedBox(width: (MediaQuery.of(context).size.width / 2) - 65),
                SizedBox(
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

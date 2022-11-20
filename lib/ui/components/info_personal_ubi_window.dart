import 'dart:core';
import 'package:flutter/material.dart';

import '../../fonts/test_icons_icons.dart';

class InfoPersonalUbiWindow extends StatelessWidget {
  final String title;
  final String? ubi;

  final String? telf;

  const InfoPersonalUbiWindow(
      {super.key, required this.title, required this.ubi, required this.telf});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 1,
              )
            ],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Colors.yellow),
            width: MediaQuery.of(context).size.width,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                  Row(
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Icon(TestIcons.eCar, size: 20)),
                      const Text("Direcció: "),
                      Text(ubi.toString())
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Icon(TestIcons.eCharger, size: 20)),
                      const Text("Telèfon: "),
                      Text(telf.toString())
                    ],
                  )
                ],
              )),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/models/BicingStation.dart';

class ListItemComponent extends StatelessWidget {
  const ListItemComponent({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    BicingStation bicingStation = new BicingStation(2, "Sardenya 280", 400, 300, 9, 1, 6, 16);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget> [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal:24),
                      decoration: ShapeDecoration(
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.zero,
                                topLeft:   Radius.circular(8),
                                bottomRight: Radius.zero,
                                topRight: Radius.circular(8)
                            ),
                          ),

                      ),
                      child: Row(
                        children: [
                          Expanded( child: Text(
                            bicingStation.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          ),
                          Expanded( child: Text(
                            bicingStation.code.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal:24),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              topLeft:   Radius.zero,
                              bottomRight: Radius.circular(8),
                              topRight: Radius.zero
                          ),
                        )
                      ),
                    child: Row(
                      children: [
                        Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child:Text(
                                  bicingStation.manbikes.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child:Text(
                                  bicingStation.elebikes.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child:Text(
                                  bicingStation.freedocks.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                        ),
                        Column(      // TEXT
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                                child:Text(
                                  bicingStation.manbikes.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child:Text(
                                bicingStation.elebikes.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child:Text(
                                  bicingStation.freedocks.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ),
                          ]
                        ) //TEXT
                      ],
                    ),
                    ),
                  ],
                ),
            ),
          ),
        ),
      );
  }
}
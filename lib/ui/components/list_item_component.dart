import 'package:flutter/material.dart';
import '../../core/models/StationList.dart';
import '../../fonts/test_icons_icons.dart';

class ListItemComponent extends StatelessWidget {
  final Station info;

  const ListItemComponent({
    Key? key,
    required this.info,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
                            info.address,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          ),
                          Expanded( child: Text(
                            info.id.toString(),
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
                    child: Column(
                      children: [
                        Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: const Icon(TestIcons.bike, size:20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child:Text(
                                  info.mechanical.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                        ),
                        Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: const Icon(TestIcons.ebike, size:20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child:Text(
                                  info.electrical.toString(),
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
                        Row(      // TEXT
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: const Icon(TestIcons.bicing_parking, size:20),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(6),
                                child:Text(
                                  info.availableSlots.toString(),
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
import 'package:flutter/material.dart';
import '../../core/models/station_list.dart';
import '../../fonts/test_icons_icons.dart';
import '../views/expandedstationpage.dart';

class BicingPreview extends StatefulWidget {
  final Station info;

  const BicingPreview({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<BicingPreview> createState() => _BicingPreviewState();
}

class _BicingPreviewState extends State<BicingPreview> {
  bool faved = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
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
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: ShapeDecoration(
                  color: Colors.blue.shade800,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.zero,
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.zero,
                        topRight: Radius.circular(8)),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.info.address,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.info.id.toString(),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.zero,
                          bottomRight: Radius.circular(8),
                          topRight: Radius.zero),
                    )
                ),
                child: Row(
                  children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Icon(TestIcons.bike, size: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                widget.info.mechanical.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Icon(TestIcons.ebike, size: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              widget.info.electrical.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        Row(// TEXT
                            children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Icon(TestIcons.bicingParking, size: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              widget.info.availableSlots.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]) //TEXT
                      ],
                    ),
                  ),
                    const VerticalDivider(),
                    Expanded(
                        flex: 1,
                        child: Column(
                            children: [
                              IconButton(onPressed: (){
                                setState(() {
                                  if (faved) {
                                    faved = false;
                                  } else {
                                    faved = true;
                                  }
                                });
                                print("faved!");
                                print(faved);
                              },
                                icon: Icon((faved) ? Icons.favorite_outline : Icons.favorite),
                              ),

                              IconButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ExpandedStationPage(index: widget.info.id, bicing: true)));
                              },
                                icon: Icon(Icons.open_in_new),
                              )

                            ]
                        )
                    )
                ])
              ),
            ],
          ),
        ),
      ),
    );
  }
}

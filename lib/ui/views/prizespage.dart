
//import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PrizesPage extends StatefulWidget {
  const PrizesPage({Key? key}) : super(key: key);

  @override
  State<PrizesPage> createState() => _PrizesPageState();
}

class _PrizesPageState extends State<PrizesPage> {
  UserController userCtrl = UserController();
  bool expandedMapCursors = false;

  List<String> prizes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"];
  List<bool> prizesLocked = [true, true, true, true, true, true, true, true, true, true, true];

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery
        .of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Prize Counter"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  height:screensize.height*0.3
                ),
                const Divider(),
                
                // Map cursors
                Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (expandedMapCursors) {
                                expandedMapCursors = false;
                              } else {
                                expandedMapCursors = true;
                              }
                            });
                          },
                          child: Row(children: [
                            const Text(
                              "Color themes",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Expanded(child: SizedBox(height: 20)),
                            Builder(builder: (context) {
                              if (expandedMapCursors) {
                                return const Icon(Icons.keyboard_arrow_up,
                                    size: 28, color: Colors.white);
                              } else {
                                return const Icon(Icons.keyboard_arrow_down,
                                    size: 28, color: Colors.white);
                              }
                            }),
                          ])
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ((expandedMapCursors)? prizes.length~/4 : 1),
                        itemBuilder: (context, index) {
                          return prizesRow(prizes[index]);
                        }
                      )
                    ])
                ),
              ],
            )
        )
    );
  }
}

Widget prizesRow(String row) {
  return Material(
      color: Colors.transparent,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Text("${row}0");
                  }),
                )
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Text("${row}1");
                  }),
                )
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Text("${row}2");
                  }),
                )
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    return Text("${row}3");
                  }),
                )
            ),
          ),
        ],
      )
  );
}
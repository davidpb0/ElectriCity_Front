
//import 'package:electricity_front/ui/components/default_header.dart';

import 'package:electricity_front/core/controllers/prize_controller.dart';
import 'package:electricity_front/core/models/prize_data.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/user_controller.dart';
import '../components/prize_preview.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PrizesPage extends StatefulWidget {
  const PrizesPage({Key? key}) : super(key: key);

  @override
  State<PrizesPage> createState() => _PrizesPageState();
}

class _PrizesPageState extends State<PrizesPage> {
  UserController userCtrl = UserController();
  PrizeController prizeCtrl = PrizeController();
  late List<bool> colors;
  late int currentColor;
  bool expandedMapCursors = false;


  @override
  void initState() {
    super.initState();
    colors = prizeCtrl.getColorAvailability();
    currentColor = prizeCtrl.getCurrentColor();
  }

  refresh(){
    setState(() {
      colors = prizeCtrl.getColorAvailability();
      currentColor = prizeCtrl.getCurrentColor();
    });
    print("refresh");
  }




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
                        itemCount: ((expandedMapCursors)? colors.length~/4 : 1),
                        itemBuilder: (context, index) {
                          int end = 4;
                          if ((index+1)*4 > colors.length){
                            end = (colors.length%4);
                          }
                          return prizesRow(index*4, end, context, colors, currentColor, refresh);
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

Widget prizesRow(int start, int end, BuildContext context, List<bool>colors, int current, Function refresh) {
  return Material(
      color: Colors.transparent,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PrizePreview(id: start, refreshParent: refresh,);
                          });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)),
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                              Image.asset(PrizeController().getColorsAsset(start)),
                              Builder(
                                  builder: (context) {
                                    if (!PrizeController().getColorsUnlocked(start)){
                                      return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.75),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: const Icon(Icons.lock_outline, size: 28,)
                                      );
                                    }
                                    else if (PrizeController().getCurrentColor() == start){
                                      return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.75),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: const Icon(Icons.check, size: 28,)
                                      );
                                    }
                                    else {
                                      return const SizedBox.shrink();
                                    }
                                  }
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(PrizeController().getColorsCost(start).toString())
                          )
                        ],
                      )
                    )
                ),
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PrizePreview(id: start+1, refreshParent: refresh,);
                          });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)),
                      ),
                      child: Builder(builder: (context) {
                        if (end < 2) {
                          return const SizedBox(height: 12, width: 12,);
                        }
                        else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.asset(PrizeController().getColorsAsset(start+1)),
                                  Builder(
                                      builder: (context) {
                                        if (!PrizeController().getColorsUnlocked(start+1)){
                                          return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.75),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                              child: const Icon(Icons.lock_outline, size: 28,)
                                          );
                                        }
                                        else if (PrizeController().getCurrentColor() == start+1){
                                          return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.75),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                              child: const Icon(Icons.check, size: 28,)
                                          );
                                        }
                                        else {
                                          return const SizedBox.shrink();
                                        }
                                      }
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(PrizeController().getColorsCost(start+1).toString())
                              )
                            ],
                          );
                        }
                      }),
                    )
                ),

            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PrizePreview(id: start+2, refreshParent: refresh);
                        });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)),
                    ),
                    child: Builder(builder: (context) {
                      if (end < 3) {
                        return const SizedBox(height: 12, width: 12,);
                      }
                      else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(PrizeController().getColorsAsset(start+2)),
                                Builder(
                                    builder: (context) {
                                      if (!PrizeController().getColorsUnlocked(start+2)){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.lock_outline, size: 28,)
                                        );
                                      }
                                      else if (PrizeController().getCurrentColor() == start+2){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.check, size: 28,)
                                        );
                                      }
                                      else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(PrizeController().getColorsCost(start+2).toString())
                            )
                          ],
                        );
                      }
                    }),
                  )
              ),
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PrizePreview(id: start+3, refreshParent: refresh);
                        });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(8)),
                    ),
                    child: Builder(builder: (context) {
                      if (end < 4) {
                        return const SizedBox(height: 12, width: 12,);
                      }
                      else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset(PrizeController().getColorsAsset(start+3)),
                                Builder(
                                    builder: (context) {
                                      if (!PrizeController().getColorsUnlocked(start+3)){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.lock_outline, size: 28,)
                                        );
                                      }
                                      else if (PrizeController().getCurrentColor() == start+3){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.check, size: 28,)
                                        );
                                      }
                                      else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                ),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(PrizeController().getColorsCost(start+3).toString())
                            )
                          ],
                        );
                      }
                    }),
                  )
              ),
            ),
          ),
        ],
      )
  );
}

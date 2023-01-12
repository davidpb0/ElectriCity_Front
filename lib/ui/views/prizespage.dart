import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:electricity_front/core/controllers/prize_controller.dart';
import 'package:electricity_front/ui/components/default_header.dart';
import 'package:flutter/material.dart';
import '../components/prize_preview.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class PrizesPage extends StatefulWidget {
  const PrizesPage({Key? key}) : super(key: key);

  @override
  State<PrizesPage> createState() => _PrizesPageState();
}

class _PrizesPageState extends State<PrizesPage> {
  //UserController userCtrl = UserController();
  PrizeController prizeCtrl = PrizeController();
  CosmeticsController cosmeticsController = CosmeticsController();
  late bool claimPrize;

  late List<bool> colors;
  late int currentColor;
  bool expandedMapCursors = false;

  late List<bool> avatars;
  late int currentAvatar;
  bool expandedAvatars = false;


  @override
  void initState(){
    super.initState();
    prizeCtrl.readPrizes();
    prizeCtrl.fetchPrizes();
    colors = prizeCtrl.getColorAvailability();
    currentColor = prizeCtrl.getCurrentColor();
    avatars = prizeCtrl.getAvatarAvailability();
    currentAvatar = prizeCtrl.getCurrentAvatar();
    claimPrize = (DateTime.now().difference(DateTime.parse(CosmeticsController().dailytimer)).inHours) < 24;
  }

  refresh(){
    setState(() {
      colors = prizeCtrl.getColorAvailability();
      currentColor = prizeCtrl.getCurrentColor();
      avatars = prizeCtrl.getAvatarAvailability();
      currentAvatar = prizeCtrl.getCurrentAvatar();
      claimPrize = (DateTime.now().difference(DateTime.parse(CosmeticsController().dailytimer)).inHours) < 24;
    });
  }




  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery
        .of(context).size;
    return Material(
      color: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
        child: Stack(
          children:[
            SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    height:screensize.height*0.15,
                    margin: EdgeInsets.only(top:screensize.height*0.18),
                    child: battlePass(claimPrize, refresh),
                  ),
                  const Divider(),

                  // Map cursors
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(cosmeticsController.getCurrentTheme().elementcoloralt),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        boxShadow: const [
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
                              Text(
                                "Color themes",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                    fontWeight: FontWeight.bold),
                              ),
                              const Expanded(child: SizedBox(height: 16)),
                              Builder(builder: (context) {
                                if (expandedMapCursors) {
                                  return Icon(Icons.keyboard_arrow_up,
                                      size: 28, color: Color(cosmeticsController.getCurrentTheme().textcolorlight));
                                } else {
                                  return Icon(Icons.keyboard_arrow_down,
                                      size: 28, color: Color(cosmeticsController.getCurrentTheme().textcolorlight));
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
                              return themesRow(index*4, end, context, colors, currentColor, refresh);
                            }
                        )
                      ])
                  ),
                  const Divider(),

                  // Avatars
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(cosmeticsController.getCurrentTheme().elementcoloralt),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        boxShadow: const [
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
                                if (expandedAvatars) {
                                  expandedAvatars = false;
                                } else {
                                  expandedAvatars = true;
                                }
                              });
                            },
                            child: Row(children: [
                              Text(
                                "Avatars",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                                    fontWeight: FontWeight.bold),
                              ),
                              const Expanded(child: SizedBox(height: 16)),
                              Builder(builder: (context) {
                                if (expandedAvatars) {
                                  return Icon(Icons.keyboard_arrow_up,
                                      size: 28, color: Color(cosmeticsController.getCurrentTheme().textcolorlight));
                                } else {
                                  return Icon(Icons.keyboard_arrow_down,
                                      size: 28, color: Color(cosmeticsController.getCurrentTheme().textcolorlight));
                                }
                              }),
                            ])
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ((expandedAvatars)? avatars.length~/4 : 1),
                            itemBuilder: (context, index) {
                              int end = 4;
                              if ((index+1)*4 > avatars.length){
                                end = (avatars.length%4);
                              }
                              return avatarsRow(index*4, end, context, avatars, currentAvatar, refresh);
                            }
                        )
                      ])
                  ),
                ],
              )
            ),
            DefaultHeader(size: Size(screensize.width, (screensize.height * 0.15))),
            Container(
              alignment: const Alignment(0 , -0.7),
              child:Container(
                  width: screensize.width/2,
                  decoration: BoxDecoration(
                    color: Color(cosmeticsController.getCurrentTheme().elementcolor),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(prizeCtrl.electricoins.toString(),
                          style: TextStyle(
                            color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        //Image.asset(name)
                      ],
                    ),
                  )
              )
            ),

          ]
        )
    );
  }
}

Widget themesRow(int start, int end, BuildContext context, List<bool>colors, int current, Function refresh) {
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
                  color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ThemePreview(id: start, refreshParent: refresh,);
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                        borderRadius: const BorderRadius.all(
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
                  color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ThemePreview(id: start+1, refreshParent: refresh,);
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                        borderRadius: const BorderRadius.all(
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
                  color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ThemePreview(id: start+2, refreshParent: refresh);
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                      borderRadius: const BorderRadius.all(
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
                  color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8)),
                ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ThemePreview(id: start+3, refreshParent: refresh);
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                      borderRadius: const BorderRadius.all(
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

Widget avatarsRow(int start, int end, BuildContext context, List<bool>avatars, int current, Function refresh) {
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
                color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                borderRadius: const BorderRadius.all(
                    Radius.circular(8)),
              ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AvatarPreview(id: start, refreshParent: refresh,);
                        });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset(PrizeController().getAvatarsAsset(start)),
                              Builder(
                                  builder: (context) {
                                    if (!PrizeController().getAvatarsUnlocked(start)){
                                      return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.75),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: const Icon(Icons.lock_outline, size: 28,)
                                      );
                                    }
                                    else if (PrizeController().getCurrentAvatar() == start){
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
                              child: Text(PrizeController().getAvatarsCost(start).toString())
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
                color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                borderRadius: const BorderRadius.all(
                    Radius.circular(8)),
              ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AvatarPreview(id: start+1, refreshParent: refresh,);
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                      borderRadius: const BorderRadius.all(
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
                                Image.asset(PrizeController().getAvatarsAsset(start+1)),
                                Builder(
                                    builder: (context) {
                                      if (!PrizeController().getAvatarsUnlocked(start+1)){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.lock_outline, size: 28,)
                                        );
                                      }
                                      else if (PrizeController().getCurrentAvatar() == start+1){
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
                                child: Text(PrizeController().getAvatarsCost(start+1).toString())
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
                color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                borderRadius: const BorderRadius.all(
                    Radius.circular(8)),
              ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AvatarPreview(id: start+2, refreshParent: refresh);
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                      borderRadius: const BorderRadius.all(
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
                                Image.asset(PrizeController().getAvatarsAsset(start+2)),
                                Builder(
                                    builder: (context) {
                                      if (!PrizeController().getAvatarsUnlocked(start+2)){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.lock_outline, size: 28,)
                                        );
                                      }
                                      else if (PrizeController().getCurrentAvatar() == start+2){
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
                                child: Text(PrizeController().getAvatarsCost(start+2).toString())
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
                color: Color(CosmeticsController().getCurrentTheme().textfieldcolor),
                borderRadius: const BorderRadius.all(
                    Radius.circular(8)),
              ),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AvatarPreview(id: start+3, refreshParent: refresh);
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                      borderRadius: const BorderRadius.all(
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
                                Image.asset(PrizeController().getAvatarsAsset(start+3)),
                                Builder(
                                    builder: (context) {
                                      if (!PrizeController().getAvatarsUnlocked(start+3)){
                                        return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.75),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(4)),
                                            ),
                                            child: const Icon(Icons.lock_outline, size: 28,)
                                        );
                                      }
                                      else if (PrizeController().getCurrentAvatar() == start+3){
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
                                child: Text(PrizeController().getAvatarsCost(start+3).toString())
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


Widget battlePass(bool available, Function refresh ){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Builder(
        builder: (context) {
          DateTime timer = DateTime.parse(CosmeticsController().dailytimer);
          if (DateTime.now().difference(timer).inHours < 6) {
            return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(CosmeticsController()
                      .getCurrentTheme()
                      .elementcolor),
                  border: Border.all(color: Color(CosmeticsController().getCurrentTheme().elementcolor+ 0x00404040), width: 4),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Color(CosmeticsController().getCurrentTheme().textfieldcolor - 0x80000000),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8)),
                        ),
                        child: Image.asset('assets/images/giftbox_closed.png', fit: BoxFit.contain,)
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Daily reward: ',
                                style: TextStyle(
                                  color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                  fontSize: 20,
                                ),),
                              Text(PrizeController().getDailyPrize().toString(),
                                style: TextStyle(
                                    color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)
                            ]
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Available to claim in ',
                              style: TextStyle(
                                  color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text('${CosmeticsController().cooldown()}h',
                              style: TextStyle(
                                  color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),

                      ],

                    ),
                  ],
                )

            );
          }
          else{
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(CosmeticsController()
                    .getCurrentTheme()
                    .accentcolor),
                border: Border.all(color: Color(CosmeticsController().getCurrentTheme().accentcolor+ 0x00404040), width: 4),
                borderRadius: const BorderRadius.all(
                    Radius.circular(16)),
              ),
              child: GestureDetector(
                onTap: () {
                  PrizeController().claimPrize();
                  refresh();
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 64,
                      height: 64,
                        decoration: BoxDecoration(
                          color: Color(CosmeticsController().getCurrentTheme().textfieldcolor - 0x80000000),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(8)),
                        ),
                      child: Image.asset('assets/images/giftbox_closed.png', fit: BoxFit.contain,)
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Daily reward: ',
                                style: TextStyle(
                                  color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                  fontSize: 20,
                                ),),
                              Text(PrizeController().getDailyPrize().toString(),
                                style: TextStyle(
                                    color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),)
                            ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Click to claim',
                              style: TextStyle(
                                  color: Color(CosmeticsController().getCurrentTheme().textcolorlight),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),

                      ],

                    ),
                  ],
                )
              )

            );
          }
        }
      )
    );
}
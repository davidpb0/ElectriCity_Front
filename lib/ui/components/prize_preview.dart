import 'package:electricity_front/core/controllers/prize_controller.dart';
import 'package:flutter/material.dart';

import '../../core/controllers/cosmetics_controller.dart';



class ThemePreview extends StatefulWidget {
  final int id;
  final Function refreshParent;

  const ThemePreview({
    Key? key,
    required this.id,
    required this.refreshParent
  }) : super(key: key);

  @override
  State<ThemePreview> createState() => _ThemePreviewState();
}

class _ThemePreviewState extends State<ThemePreview> {
  final PrizeController _prizeController = PrizeController();

  late bool locked;
  late bool using;
  Color costColor = Color(CosmeticsController().getCurrentTheme().textcolordark);


  @override
  void initState() {
    super.initState();
    locked = !_prizeController.getColorsUnlocked(widget.id);
    using = _prizeController.getCurrentColor() == widget.id;
  }


  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    Size screensize = MediaQuery
        .of(context).size;
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(vertical: screensize.height*0.25, horizontal: screensize.width*0.15),
        child: Container(
          decoration: BoxDecoration(
            color: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
            borderRadius: const BorderRadius.all(
                Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: screensize.width*0.25,
                  decoration: BoxDecoration(
                    color: Color(cosmeticsController.getCurrentTheme().textcolorlight),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(16)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(_prizeController.getColorsAsset(widget.id)),
                      Visibility(
                          visible: locked,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4)),
                              ),
                              child: const Icon(Icons.lock_outline, size: 40,)
                          )
                      )
                    ],
                  )
              ),
              Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Expanded(
                        flex:1,
                        child: SizedBox()
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            _prizeController.getColorsCost(widget.id).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: costColor
                            ),
                          )
                      ),
                    ),
                    const Expanded(
                        flex:1,
                        child: SizedBox()
                    ),
                  ]
              ),
              Visibility(
                visible: !using,
                child: GestureDetector(
                  onTap: () {
                    if(locked){
                      if (_prizeController.spendCoins(_prizeController.getColorsCost(widget.id))){
                        _prizeController.unlockColor(widget.id);
                        setState(() {
                          locked = false;
                        });
                      }
                      else{
                        setState(() {
                          costColor = Color(CosmeticsController().getCurrentTheme().elementcolordelete);
                        });
                    }
                      widget.refreshParent();
                    }
                    else if (!using){
                      _prizeController.setColor(widget.id);
                      setState(() {
                        using = true;
                      });
                      widget.refreshParent();
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(cosmeticsController.getCurrentTheme().accentcolor),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(16)),
                      ),
                      child:  Text(
                        (locked)? 'Unlock' : 'Select',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(cosmeticsController.getCurrentTheme().textcolorlight)
                        ),
                      )
                  ),
                ),),

            ],
          ),
        )
    );
  }
}

class AvatarPreview extends StatefulWidget {
  final int id;
  final Function refreshParent;

  const AvatarPreview({
    Key? key,
    required this.id,
    required this.refreshParent
  }) : super(key: key);

  @override
  State<AvatarPreview> createState() => _AvatarPreviewState();
}

class _AvatarPreviewState extends State<AvatarPreview> {
  final PrizeController _prizeController = PrizeController();

  late bool locked;
  late bool using;
  Color costColor = Color(CosmeticsController().getCurrentTheme().textcolordark);


  @override
  void initState() {
    super.initState();
    locked = !_prizeController.getAvatarsUnlocked(widget.id);
    using = _prizeController.getCurrentAvatar() == widget.id;
  }


  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    Size screensize = MediaQuery
        .of(context).size;
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(vertical: screensize.height*0.25, horizontal: screensize.width*0.15),
        child: Container(
          decoration: BoxDecoration(
            color: Color(cosmeticsController.getCurrentTheme().backgroundcolor),
            borderRadius: const BorderRadius.all(
                Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: screensize.width*0.25,
                  decoration: BoxDecoration(
                    color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(16)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(_prizeController.getAvatarsAsset(widget.id)),
                      Visibility(
                          visible: locked,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4)),
                              ),
                              child: const Icon(Icons.lock_outline, size: 40,)
                          )
                      )
                    ],
                  )
              ),
              Flex(
                  direction: Axis.horizontal,
                  children: [
                    const Expanded(
                        flex:1,
                        child: SizedBox()
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            _prizeController.getAvatarsCost(widget.id).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: costColor
                            ),
                          )
                      ),
                    ),
                    const Expanded(
                        flex:1,
                        child: SizedBox()
                    ),
                  ]
              ),
              Visibility(
                visible: !using,
                child: GestureDetector(
                  onTap: () {
                    if(locked){
                      if (_prizeController.spendCoins(_prizeController.getAvatarsCost(widget.id))){
                        _prizeController.unlockAvatar(widget.id);
                        setState(() {
                          locked = false;
                        });
                      }
                      else{
                        setState(() {
                          costColor = Color(CosmeticsController().getCurrentTheme().elementcolordelete);
                        });
                      }
                      widget.refreshParent();
                    }
                    else if (!using){
                      _prizeController.setAvatar(widget.id);
                      setState(() {
                        using = true;
                      });
                      widget.refreshParent();
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(cosmeticsController.getCurrentTheme().accentcolor),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(16)),
                      ),
                      child:  Text(
                        (locked)? 'Unlock' : 'Select',
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(cosmeticsController.getCurrentTheme().textcolorlight)
                        ),
                      )
                  ),
                ),),

            ],
          ),
        )
    );
  }
}
import 'package:electricity_front/core/controllers/prize_controller.dart';
import 'package:flutter/material.dart';

import '../../core/controllers/cosmetics_controller.dart';



class PrizePreview extends StatefulWidget {
  final int id;
  final Function refreshParent;

  const PrizePreview({
    Key? key,
    required this.id,
    required this.refreshParent
  }) : super(key: key);

  @override
  State<PrizePreview> createState() => _PrizePreviewState();
}

class _PrizePreviewState extends State<PrizePreview> {
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
    Size screensize = MediaQuery
        .of(context).size;
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(vertical: screensize.height*0.25, horizontal: screensize.width*0.15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
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
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
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
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                            Radius.circular(16)),
                      ),
                      child:  Text(
                        (locked)? 'Unlock' : 'Select',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
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
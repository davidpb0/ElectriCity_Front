import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PersonalUbiPreview extends StatelessWidget {
  final Marker info;

  const PersonalUbiPreview({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CosmeticsController cosmeticsController = CosmeticsController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(cosmeticsController.getCurrentTheme().elementcolordark),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: ShapeDecoration(
                  color: Color(cosmeticsController.getCurrentTheme().elementcolorubi),
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
                        info.infoWindow.title.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(cosmeticsController.getCurrentTheme().textcolordark),
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
                decoration: ShapeDecoration(
                    color: Color(cosmeticsController.getCurrentTheme().textfieldcolor),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.zero,
                          bottomRight: Radius.circular(8),
                          topRight: Radius.zero),
                    )
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Icon(Icons.home_work, size: 20, color: Color(cosmeticsController.getCurrentTheme().textcolordark)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            info.infoWindow.snippet.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(cosmeticsController.getCurrentTheme().textcolordark),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ), //TEXT
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

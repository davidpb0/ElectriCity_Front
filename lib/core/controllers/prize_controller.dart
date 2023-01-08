
import 'package:electricity_front/core/controllers/cosmetics_controller.dart';
import 'package:electricity_front/core/services/api_service.dart';
import '../../core/models/prize_data.dart';

import '../../core/controllers/user_controller.dart';

class PrizeController {
  final ApiService _apiService = ApiService();
  final CosmeticsController _cosmeticsController = CosmeticsController();
  //UserController userCtrl = UserController();
  late List<ColorPrize> _colors;
  late List<bool> _colorsUnlocked;
  late int _currentColor;
  int electricoins = 50000;
  /*final List<ColorPrize> _colors = [
    ColorPrize(0,250,'assets/images/prizes/colores_1.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800]
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(1,250,'assets/images/prizes/colores_2.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF607D8B, // alt element color: blueGrey
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF2196F3, // accent color: blue
      0XFF1565C0, // alt accent color: blue[800]
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(2,250,'assets/images/prizes/colores_3.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(3,250,'assets/images/prizes/colores_4.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(4,250,'assets/images/prizes/colores_5.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(5,250,'assets/images/prizes/colores_6.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(6,250,'assets/images/prizes/colores_7.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
    ColorPrize(7,250,'assets/images/prizes/colores_8.png',
      0XFFE0E0E0, // background color: grey[200]
      0XFF9E9E9E, // element color: grey
      0XFF616161, // dark element color: grey[700]
      0XFF54744E, // alt element color: greengrey (custom)
      0XFF1565C0, // bicing color: blue[800]
      0XFF2E7D32, // recharge color: green[800]
      0XFFFFEB3B, // ubi color: yellow
      0XFFD32F2F, // delete color: red[700]
      0XFF4CAF50, // accent color: green
      0XFF2E7D32, // alt accent color: green[800
      0XFFFFFFFF, // light text color: white
      0XFF000000, // dark text color: black
    ),
  ];*/





  factory PrizeController() {
    return _this;
  }

  static final PrizeController _this = PrizeController._();

  PrizeController._();

  void readColors() async {
    _colorsUnlocked = _cosmeticsController.unlocked;
    _currentColor = _cosmeticsController.current;
    _colors = _cosmeticsController.getAllThemes();

  }

  List<bool> getColorAvailability(){
    return _colorsUnlocked;
  }

  String getColorsAsset (int index){
    return _colors[index].asset;
  }

  int getColorsCost (int index){
    return _colors[index].cost;
  }

  int getTotalColors(){
    return _colors.length;
  }

  bool getColorsUnlocked (int index){
    return _colorsUnlocked[index];
  }

  int getCurrentColor() {
    return _currentColor;
  }

  void unlockColor(int index){
    _colorsUnlocked[index] = true;
  }

  void setColor(int index){
    _currentColor = index;
    _cosmeticsController.current = index;
  }

  bool spendCoins(int price){
    if (price > electricoins) {
      return false;
    }
    electricoins -= price;
    return true;
  }



}

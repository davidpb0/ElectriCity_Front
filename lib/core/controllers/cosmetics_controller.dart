import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/prize_data.dart';

class CosmeticsController {
  final List<ColorPrize> _colors = [];
  late int current;
  final List<bool> unlocked = [];

  factory CosmeticsController() {
    return _this;
  }

  static final CosmeticsController _this = CosmeticsController._();

  CosmeticsController._();




  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/themeData.txt');
  }

  Future<void> readThemes() async {
    print("entro");
    String contents;
    try {
      final file = await _localFile;

      // Read the file
      contents = await file.readAsString();
      print("file: " + contents);
      if (contents.isEmpty){
        contents = '0-10000000 250,assets/images/prizes/colores_1.png,0XFFE0E0E0,0xFFEEEEEE,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_2.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF607D8B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF2196F3,0XFF1565C0,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_3.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_4.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_5.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_6.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_7.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_8.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000';
      }


    } catch (e) {
      print(e);
      contents = '0-10000000 250,assets/images/prizes/colores_1.png,0XFFE0E0E0,0xFFEEEEEE,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_2.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF607D8B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF2196F3,0XFF1565C0,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_3.png,0XFFE0E0E0,0xFFFFFFFF,0XFFD6C8D8,0XFF616161,0XFF725B7B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF9C27B0,0XFF6A1A9B,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_4.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_5.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_6.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_7.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_8.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000';

    }
    final splitted = contents.split(" ");
    final spdata = splitted[0].split("-");
    current = int.parse(spdata[0]);
    for(int j=0; j<spdata[1].length; ++j){
      unlocked.add((spdata[1][j] == '1')? true : false);
    }
    for(int i=1; i<splitted.length; ++i){
      _colors.add(ColorPrize.fromString(i, splitted[i]));
      print("read color $i");
      print("list size: ${_colors.length}");
    }
    print(spdata[1].length);

    print(unlocked);
  }

  Future<File> writeThemes() async {
    final file = await _localFile;
    String joined = '$current-';
    for(int h=0; h<unlocked.length; ++h){
      joined += (unlocked[h] == true)? '1' : '0';
    }
    for(int i=0; i<_colors.length; ++i){
      joined += ' $_colors[i]';
    }
    // Write the file
    return file.writeAsString(joined);
  }


  List<ColorPrize> getAllThemes(){
    return _colors;
  }

  ColorPrize getCurrentTheme(){
    return _colors[current];
  }
}
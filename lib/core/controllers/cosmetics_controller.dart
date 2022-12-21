import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/prize_data.dart';

class CosmeticsController {
  late final List<ColorPrize> _colors;
  late int current;

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
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      final splitted = contents.split(" ");
      for(int i=0; i<splitted.length; ++i){
        _colors.add(ColorPrize.fromString(i+1, splitted[i]));
      }
    } catch (e) {
      // If encountering an error, return 0
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }

  ColorPrize getTheme(int i){
    return _colors[i];
  }
}
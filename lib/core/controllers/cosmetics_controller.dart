import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/prize_data.dart';

class CosmeticsController {
  final List<ColorPrize> _colors = [];
  late int currentTheme;
  final List<bool> unlockedThemes = [];

  final List<AvatarPrize> _avatars = [];
  late int currentAvatar;
  final List<bool> unlockedAvatars = [];

  late String dailytimer;
  late int streak;


  factory CosmeticsController() {
    return _this;
  }

  static final CosmeticsController _this = CosmeticsController._();

  CosmeticsController._();




  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _themeFile async {
    final path = await _localPath;
    return File('$path/themeData.txt');
  }

  Future<File> get _avatarFile async {
    final path = await _localPath;
    return File('$path/avatarData.txt');
  }

  Future<File> get _counterFile async {
    final path = await _localPath;
    return File('$path/counterData.txt');
  }

  Future<void> readThemes() async {
    String contents;
    try {
      final file = await _themeFile;

      // Read the file
      contents = await file.readAsString();
      if (contents.isEmpty){
        contents = '0-10000000 250,assets/images/prizes/colores_1.png,0XFFE0E0E0,0xFFEEEEEE,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_2.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF607D8B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF2196F3,0XFF1565C0,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_3.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_4.png,0XFF151514,0xFF202020,0XFF9E9E9E,0XFF616161,0XFF607D8B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF1565C0,0XFF2196F3,0XFFFFFFFF,0XFFFFFFFF 250,assets/images/prizes/colores_5.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_6.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_7.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_8.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000';
      }


    } catch (e) {
      contents = '0-10000000 250,assets/images/prizes/colores_1.png,0XFFE0E0E0,0xFFEEEEEE,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_2.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF607D8B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF2196F3,0XFF1565C0,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_3.png,0XFFE0E0E0,0xFFFFFFFF,0XFFD6C8D8,0XFF616161,0XFF725B7B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF9C27B0,0XFF6A1A9B,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_4.png,0XFF151514,0xFF202020,0XFF9E9E9E,0XFF616161,0XFF607D8B,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF1565C0,0XFF2196F3,0XFFFFFFFF,0XFFFFFFFF 250,assets/images/prizes/colores_5.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_6.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_7.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000 250,assets/images/prizes/colores_8.png,0XFFE0E0E0,0xFFFFFFFF,0XFF9E9E9E,0XFF616161,0XFF54744E,0XFF1565C0,0XFF2E7D32,0XFFFFEB3B,0XFFD32F2F,0XFF4CAF50,0XFF2E7D32,0XFFFFFFFF,0XFF000000';
      final file = await _themeFile;
      writeFirstTime(file, contents);
    }
    if(_colors.length<8){
      final splitted = contents.split(" ");
      final spdata = splitted[0].split("-");
      currentTheme = int.parse(spdata[0]);
      for(int j=0; j<spdata[1].length; ++j){
        unlockedThemes.add((spdata[1][j] == '1')? true : false);
      }
      for(int i=1; i<splitted.length; ++i){
        _colors.add(ColorPrize.fromString(i, splitted[i]));
      }
    }
  }

  Future<void> readAvatars() async {
    String contents;
    try {
      final file = await _avatarFile;

      // Read the file
      contents = await file.readAsString();
      if (contents.isEmpty){
        contents = '0-100000000000 250,assets/images/prizes/avatar_01.png 250,assets/images/prizes/avatar_02.png 250,assets/images/prizes/avatar_03.png 250,assets/images/prizes/avatar_04.png 250,assets/images/prizes/avatar_05.png 250,assets/images/prizes/avatar_06.png 250,assets/images/prizes/avatar_07.png 250,assets/images/prizes/avatar_08.png 250,assets/images/prizes/avatar_09.png 250,assets/images/prizes/avatar_10.png 250,assets/images/prizes/avatar_11.png 250,assets/images/prizes/avatar_12.png';
      }


    } catch (e) {
      contents = '0-100000000000 250,assets/images/prizes/avatar_01.png 250,assets/images/prizes/avatar_02.png 250,assets/images/prizes/avatar_03.png 250,assets/images/prizes/avatar_04.png 250,assets/images/prizes/avatar_05.png 250,assets/images/prizes/avatar_06.png 250,assets/images/prizes/avatar_07.png 250,assets/images/prizes/avatar_08.png 250,assets/images/prizes/avatar_09.png 250,assets/images/prizes/avatar_10.png 250,assets/images/prizes/avatar_11.png 250,assets/images/prizes/avatar_12.png';
      final file = await _avatarFile;
      writeFirstTime(file, contents);
    }
    if(unlockedAvatars.isEmpty){
      final splitted = contents.split(" ");
      final spdata = splitted[0].split("-");
      currentAvatar = int.parse(spdata[0]);
      for(int j=0; j<spdata[1].length; ++j){
        unlockedAvatars.add((spdata[1][j] == '1')? true : false);
      }
      for(int i=1; i<splitted.length; ++i){
        _avatars.add(AvatarPrize.fromString(i, splitted[i]));
      }
    }




  }


  Future<File> writeThemes() async {
    final file = await _themeFile;
    String joined = '$currentTheme-';
    for(int h=0; h<unlockedThemes.length; ++h){
      joined += (unlockedThemes[h] == true)? '1' : '0';
    }
    for(int i=0; i<_colors.length; ++i){
      joined += ' ${_colors[i]}';
    }
    // Write the file
    return file.writeAsString(joined);
  }

  Future<File> writeAvatars() async {
    final file = await _avatarFile;
    String joined = '$currentAvatar-';
    for(int h=0; h<unlockedAvatars.length; ++h){
      joined += (unlockedAvatars[h] == true)? '1' : '0';
    }
    for(int i=0; i<_avatars.length; ++i){
      joined += ' ${_avatars[i]}';
    }
    // Write the file
    return file.writeAsString(joined);
  }

  Future<File> writeFirstTime( File file, String content) async {
    return file.writeAsString(content);
  }

  Future<void> readCounter() async {
    String contents;
    try {
      final file = await _counterFile;

      // Read the file
      contents = await file.readAsString();
      if (contents.isEmpty){
        contents = '${DateTime.now().subtract(const Duration(days:1))}//0';
      }


    } catch (e) {
      contents = '${DateTime.now().subtract(const Duration(days:1))}//0';
      final file = await _counterFile;
      writeFirstTime(file, contents);
    }
    final splitted = contents.split("//");
    dailytimer = splitted[0];
    streak = int.parse(splitted[1]);
    if (DateTime.now().difference(DateTime.parse(CosmeticsController().dailytimer)).inHours > 24){
      streak = 0;
    }


  }

  Future<File> writeCounter() async {
    final file = await _counterFile;
    dailytimer = DateTime.now().toString();
    streak++;
    String joined = '$dailytimer//$streak';
    // Write the file
    return file.writeAsString(joined);
  }


  List<ColorPrize> getAllThemes(){
    return _colors;
  }

  ColorPrize getCurrentTheme(){
    return _colors[currentTheme];
  }

  ColorPrize getDefaultTheme(){
    return _colors[0];
  }

  void unlockColor(int index){
    unlockedThemes[index] = true;
    writeThemes();
  }

  void selectColor(int index){
    currentTheme = index;
    writeThemes();
  }

  List<AvatarPrize> getAllAvatars(){
    return _avatars;
  }

  AvatarPrize getCurrentAvatar(){
    return _avatars[currentAvatar];
  }

  void unlockAvatar(int index){
    unlockedAvatars[index] = true;
    writeAvatars();
  }

  void selectAvatar(int index){
    currentAvatar = index;
    writeAvatars();
  }

  int cooldown(){
    return 6 - (DateTime.now().difference(DateTime.parse(CosmeticsController().dailytimer)).inHours);
  }
}
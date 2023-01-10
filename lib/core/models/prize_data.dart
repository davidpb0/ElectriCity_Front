
class ColorPrize {
  final int id;
  final int cost;
  final String asset;

  final int backgroundcolor;
  final int textfieldcolor;
  final int elementcolor;
  final int elementcolordark;
  final int elementcoloralt;
  final int elementcolorbicing;
  final int elementcolorcharger;
  final int elementcolorubi;
  final int elementcolordelete;
  final int accentcolor;
  final int accentcoloralt;
  final int textcolorlight;
  final int textcolordark;



  ColorPrize (
      this.id,
      this.cost,
      this.asset,

      //Theme color codes
      this.backgroundcolor,
      this.textfieldcolor,
      this.elementcolor,
      this.elementcolordark,
      this.elementcoloralt,
      this.elementcolorbicing,
      this.elementcolorcharger,
      this.elementcolorubi,
      this.elementcolordelete,
      this.accentcolor,
      this.accentcoloralt,
      this.textcolorlight,
      this.textcolordark);

  factory ColorPrize.fromString(int id, String data){
    final splitted = data.split(",");
    print(splitted.length);
    return ColorPrize(id, int.parse(splitted[0]), splitted[1], int.parse(splitted[2]), int.parse(splitted[3]), int.parse(splitted[4]), int.parse(splitted[5]), int.parse(splitted[6]), int.parse(splitted[7]), int.parse(splitted[8]), int.parse(splitted[9]), int.parse(splitted[10]), int.parse(splitted[11]), int.parse(splitted[12]), int.parse(splitted[13]), int.parse(splitted[14]));
  }

  String toString(){
    return '$cost,$asset,$backgroundcolor,$textfieldcolor,$elementcolor,$elementcolordark,$elementcoloralt,$elementcolorbicing,$elementcolorcharger,$elementcolorubi,$elementcolordelete,$accentcolor,$accentcoloralt,$textcolorlight,$textcolordark';
  }

}

class AvatarPrize {
  final int id;
  final int cost;
  final String asset;



  AvatarPrize (
      this.id,
      this.cost,
      this.asset);


  factory AvatarPrize.fromString(int id, String data){
    final splitted = data.split(",");
    return AvatarPrize(id, int.parse(splitted[0]), splitted[1]);
  }

  String toString(){
    return '$cost,$asset';
  }

}
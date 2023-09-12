import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray5066 = fromHex('#66fbfcfc');

  static Color gray5001 = fromHex('#fcfcfc');

  static Color gray5002 = fromHex('#fcfcfd');

  static Color blueGray5099 = fromHex('#99edeef1');

  static Color blueGray50 = fromHex('#edeef1');

  static Color gray90033 = fromHex('#33131416');

  static Color green50019 = fromHex('#1948bc65');

  static Color blue50061 = fromHex('#611786f9');

  static Color red400 = fromHex('#eb5a5a');

  static Color black9003f = fromHex('#3f000000');

  static Color gray50 = fromHex('#f9f9fa');

  static Color green500 = fromHex('#48bc65');

  static Color gray30099 = fromHex('#99d8dae2');

  static Color red40019 = fromHex('#19eb5a5a');

  static Color black900 = fromHex('#000000');

  static Color yellow700 = fromHex('#fabe3c');

  static Color teal900 = fromHex('#082d53');

  static Color blueGray40014 = fromHex('#14718096');

  static Color blueGray900 = fromHex('#29303c');

  static Color red4000c = fromHex('#0ceb5a5a');

  static Color blueGray5001 = fromHex('#eeeff2');

  static Color gray5099 = fromHex('#99f9f9fa');

  static Color gray700 = fromHex('#5d5f6f');

  static Color blueGray5087 = fromHex('#87edeef1');

  static Color blueGray400 = fromHex('#8b8fa7');

  static Color blue500 = fromHex('#1786f9');

  static Color gray900 = fromHex('#131416');

  static Color blueGray500 = fromHex('#74778b');

  static Color gray300 = fromHex('#d8dae2');

  static Color blue50 = fromHex('#d1e7fe');

  static Color gray9007e = fromHex('#7e131416');

  static Color blueGray1000f = fromHex('#0fc5c7d3');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
  
}
class ColorConstant2 {
  static Color blueGray10001 = fromHex('#caccd2');

  static Color blueGray10002 = fromHex('#d0d2d7');

  static Color greenA70001 = fromHex('#00d259');

  static Color blueGray60014 = fromHex('#14545e7a');

  static Color black9003f = fromHex('#3f000000');

  static Color gray50 = fromHex('#f8f8f8');

  static Color gray2003f = fromHex('#3fe8e8e8');

  static Color red50 = fromHex('#fdeeea');

  static Color teal300 = fromHex('#4ca6a8');

  static Color greenA700 = fromHex('#00d258');

  static Color yellowA400 = fromHex('#f7ee00');

  static Color black900 = fromHex('#000000');

  static Color teal700 = fromHex('#007274');

  static Color gray50001 = fromHex('#a8a8aa');

  static Color purpleA700 = fromHex('#8b00f7');

  static Color deepOrangeA700 = fromHex('#e72f00');

  static Color gray20001 = fromHex('#f2eaea');

  static Color blueGray700 = fromHex('#4b5060');

  static Color blueGray900 = fromHex('#363636');

  static Color redA700 = fromHex('#ff0000');

  static Color purple50 = fromHex('#fdeafc');

  static Color tealA700 = fromHex('#04d79a');

  static Color gray600 = fromHex('#7b7b7b');

  static Color gray700 = fromHex('#616471');

  static Color gray400 = fromHex('#bcbcbc');

  static Color gray500 = fromHex('#a7a8aa');

  static Color blueGray100 = fromHex('#d0d1d6');

  static Color blueGray400 = fromHex('#888888');

  static Color indigo50 = fromHex('#ebeafd');

  static Color amber600 = fromHex('#ffb905');

  static Color gray800 = fromHex('#4b4b4b');

  static Color redA200 = fromHex('#ff4b55');

  static Color gray900 = fromHex('#071232');

  static Color gray90001 = fromHex('#121111');

  static Color gray7007e = fromHex('#7e616471');

  static Color red5001 = fromHex('#fdeaeb');

  static Color teal50 = fromHex('#e4f3f4');

  static Color gray200 = fromHex('#eeeeee');

  static Color gray300 = fromHex('#e6e6e6');

  static Color gray30001 = fromHex('#e3e3e1');

  static Color gray100 = fromHex('#f3f4ef');

  static Color tealA400 = fromHex('#00f7bd');

  static Color gray10002 = fromHex('#f5f5f5');

  static Color gray10001 = fromHex('#f4f4f4');

  static Color lime50 = fromHex('#fdf9ea');

  static Color whiteA700 = fromHex('#ffffff');

  static Color blueGray70001 = fromHex('#4a505f');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

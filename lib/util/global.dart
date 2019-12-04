import 'package:flutter/cupertino.dart';

class Global {
  /// 服务器地址
  static String serverUlr;

  /// 屏幕宽高
  static double screenWidth;
  static double screenHeight;

  static init(BuildContext context) async {
    print(MediaQuery.of(context).size);
    screenWidth = MediaQuery.of(context).size.width;
    screenWidth = MediaQuery.of(context).size.height;
  }
}
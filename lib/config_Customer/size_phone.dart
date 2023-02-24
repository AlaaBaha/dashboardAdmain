import 'package:flutter/material.dart';
class size_phone{
  static double? height;
  static double? width;
  static double? defualtsize;
  static Orientation? orientation;
 void  init(BuildContext context){
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    orientation=MediaQuery.of(context).orientation;
    defualtsize=orientation==Orientation.landscape?height!*.025:width!*.025;

  }

}
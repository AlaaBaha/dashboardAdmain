import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
class Text_Style{
  //color: Color.fromRGBO(74, 112, 122, 1.0),

TextStyle  StyleFount({required double size,required String fountFamily,required Color color ,}){
  return TextStyle(
      color:color,
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: fountFamily,
    decoration: TextDecoration.none

  );
}
animationText(String text,TextStyle style){
  return AnimatedTextKit(
    repeatForever: true,
    animatedTexts: [TypewriterAnimatedText(text,textStyle: style,
        speed: Duration(milliseconds: 100),cursor: '')],);
}
}
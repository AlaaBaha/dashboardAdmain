import 'package:flutter/material.dart';

import '../../config_Customer/size_phone.dart';

class Customer_config{
  static double shadow=0;

  size_phone size=size_phone();

  static CustomerButton(String text,Color colorBack, Color fount,double hieght,double width,void Function() fun){
    return GestureDetector(
      onTap: (){
        shadow=5;
      },
      child: TextButton(
        onPressed: fun,
        child: Container(
          height:hieght,
          width: width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,0),
                    spreadRadius: shadow,
                    blurRadius: shadow


                )
              ],
              color: colorBack,
              borderRadius: BorderRadius.circular(size_phone.defualtsize!*3)
          ),
          child: Center(child: Text(text,style: TextStyle(color: fount,fontFamily: 'body',fontSize:size_phone.defualtsize!*1.4),),),
        ),),
    );
  }

}

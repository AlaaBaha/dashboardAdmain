
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
class Alert_Config{

 Alert({required  dynamic Function() fun,required BuildContext context,required String title,required CoolAlertType type})
 {
return  CoolAlert.show(
onConfirmBtnTap: fun ,
title: "",
confirmBtnText: "موافق",
confirmBtnTextStyle: Text_Style().StyleFount(size: 18, fountFamily: "body", color: Colors.white),
width: 100,
context: context,
type:type,
text:title,
 backgroundColor:ColorForm,
 confirmBtnColor: ColorForm,
);
}
}
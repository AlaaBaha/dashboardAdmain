import 'package:admaindashboard/Model/product_model/product_model.dart';
import 'package:admaindashboard/config_Customer/alert.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class product_controller{
  var AllProduct =product_model().All_Product;


Delete_Product(String ID,BuildContext context){
  String change="هل تريد مسح المنتج ؟";
  var temp=CoolAlertType.warning;

    Alert_Config().Alert(
      fun: (){
        product_model().DeleteProduct(ID);
        Navigator.pop(context);
      },
      context: context,
      type: temp,
      title:change ,);
  // else
  // {
  //   Alert_Config().Alert(
  //     fun: (){
  //       Navigator.pop(context);
  //     },
  //     context: context,
  //     type: CoolAlertType.success,
  //     title: 'فشل رفض الطلب ',);}
}
}
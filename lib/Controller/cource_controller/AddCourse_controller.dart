import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:admaindashboard/Model/AddCourse_Model/AddCouse_model.dart';
import 'package:admaindashboard/config_Customer/alert.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";
class AddCourse_controller{
  AddCouse_model addCouse_model=AddCouse_model();
var All_Reuest=AddCouse_model().Request_Corse;
List<String> catalogers=AddCouse_model().Catalog;

  Future<void> AddCouse(BuildContext context, String Name,String catalog,String FileName,
      Uint8List? ImgFile, String linked)async{
    bool res= await addCouse_model.AddCouse(Name: Name, catalog: catalog, nameFile: FileName, ImgFile: ImgFile, linked: linked);
    size_phone().init(context);
    if(res)
    {
      Alert_Config().Alert(
        fun: (){
          Navigator.pop(context);
        },
        context: context,
        type: CoolAlertType.success,
        title: 'تم تحميل الكورس  ',);}

    else
    { Alert_Config().Alert(
      fun:(){Navigator.pop(context);},
      context: context,
      type: CoolAlertType.error,
      title: "فشل تحميل الكورس",
    );}
}
getCourseDetail(String id){
  return AddCouse_model().getCourseDetail(id);
}
  DeleteCourse(String id,BuildContext context){
    bool val = AddCouse_model().DeleteCourse(id);
    if(val)  {
      Alert_Config().Alert(
        fun: (){
          Navigator.pop(context);
        },
        context: context,
        type: CoolAlertType.success,
        title: 'تم رفض الطلب   ',);}
    else
    {
      Alert_Config().Alert(
        fun: (){
          Navigator.pop(context);
        },
        context: context,
        type: CoolAlertType.success,
        title: 'فشل رفض الطلب ',);}
  }
  EmailOpen(String UserEmail,String title) async {
  // final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  // const seviceid="service_cgohnol";
  // const templateid="template_dxd01z9";
  // const userid="oVguU9KJ0eizPA6b7";
  //
  // final reponend=await http.post(url,
  //     headers: {'Content-Type':'application/json'},
  //     body: json.encode({
  //       "service_id":seviceid,
  //       "template_id":templateid,
  //       "user_id":userid,
  //       "template_params":{
  //         "name":"منصة تنوير  ",
  //         "subject":"الرد على طلب مرسل ! ",
  //         "message":title,
  //         "user_email":UserEmail!
  //       },
  //       "accessToken":"I4n1w1XMb1_jlmzsIYgB6"}));
  // reponend.statusCode;
  // print(reponend.statusCode);


  }

}

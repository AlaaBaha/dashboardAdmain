import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/config_Customer/alert.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import"package:flutter/material.dart";
import 'package:cool_alert/cool_alert.dart';
import '../../model/Auth_Model/Auth_DB.dart';

class Auth_Controller{
  size_phone size=size_phone();
  Auth_Model auth=Auth_Model();
  SignUpAlert(BuildContext context,email, password, dynamic Function() param3 )async{
    String val=await auth.signUp(email, password);
    if(val=="true")
      Alert_Config().Alert(
          fun: (){
            Navigator.popAndPushNamed(context, RouteNames.home);
          },
          context: context,
          title: "تم انشاء الحساب",
          type: CoolAlertType.success);
    else
      if(val=="The email address is already in use by another account."){
        Alert_Config().Alert(
          fun:  (){
          Navigator.popAndPushNamed(context, "login");
        },
        context: context,
        type: CoolAlertType.error,
        title: "لديك جساب بالفعل قم بتسجيل الدخول",);
}
    else
      if(val=="network-request-failed"){
        Alert_Config().Alert(
            fun:  (){
          Navigator.pop(context);
        },
        context: context,
        type: CoolAlertType.error,
        title: "تاكد من الاتصال بالانترنت",
        );}
  }
  LoginAlert(BuildContext context,String email,String password, )async{
    size.init(context);
    bool val= await auth.log(email, password);
    if(val)
    {
      Alert_Config().Alert(
        fun:  (){
          Navigator.popAndPushNamed(context, RouteNames.home);

        } ,
        context: context,
        type: CoolAlertType.success,
        title: "تم تسجيل الدخول",
      );

    }
    else
      Alert_Config().Alert(
        fun: (){Navigator.pop(context);},
        context: context,
        type: CoolAlertType.error,
        title: "تاكد من الاتصال بالانترنت\n او تاكد من صحة البيانات المدخلة",
      );

  }
  deleteUser(String id,BuildContext context){
    Alert_Config().Alert(
      fun:  () async {
        await auth.deleteUser(id);
        Navigator.pop(context, );

      } ,
      context: context,
      type: CoolAlertType.warning,
      title: "هل تريد حذف المستخدم ؟",
    );
    ;
  }
  LogoutAlert(BuildContext context)async{
    size.init(context);
    bool val= await auth.signOut(context);
    if(val){
      Alert_Config().Alert(
        fun:  (){
          Navigator.pushReplacementNamed(context, RouteNames.login);
        } ,
      context: context,
      type: CoolAlertType.success,
      title: " تمت عملية تسجيل الخروج",
     );

  }
  else
  CoolAlert.show(
  onConfirmBtnTap: (){},
  context: context,
  type: CoolAlertType.error,
  width: 100,

    title: "",
    confirmBtnText: "موافق",
  text: "تاكد من الاتصال بالانترنت",
    confirmBtnTextStyle: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.white),
  );


  }
  //
  // void requestVerfication(bool val,BuildContext context) {
  //   if(val)
  //   {
  //     CoolAlert.show(
  //
  //       confirmBtnTextStyle: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.white),
  //       onConfirmBtnTap: (){} ,
  //       width: 100,
  //       context: context,
  //       type: CoolAlertType.success,
  //       text: " تم حذف الحساب ",
  //     );
  //
  //   }
  //   else
  //     CoolAlert.show(
  //
  //       confirmBtnTextStyle: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.white),
  //       onConfirmBtnTap: (){},
  //       context: context,
  //       type: CoolAlertType.error,
  //       width: 100,
  //       backgroundColor: Colors.red,
  //       text: "فشل  حذف الحساب ",
  //     );
  // }
}

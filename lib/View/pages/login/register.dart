
import 'package:admaindashboard/Controller/Auth_controller/Auth_Controller.dart';
import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'login.dart';
class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => registerState();
}

class registerState extends State<register> {
  bool select=false;
  bool downnload=false;
  String validEmail= '^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)\$';
  TextEditingController Email =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController passwordRet =TextEditingController();
  GlobalKey<FormState> _key=GlobalKey<FormState>();
  Auth_Controller auth=Auth_Controller();

  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    print(size_phone.width);
    var sizephone=MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor:ColorForm.withOpacity(.1),
          body: SafeArea(
            child: Center(
              child:  InkWell(
                child:Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.all(size_phone.defualtsize!*2.5),
                    height:size_phone.width!<=500?size_phone.defualtsize!*40:size_phone.defualtsize!*35 ,
                    width: size_phone.defualtsize!*40,
                    margin: EdgeInsets.only(right:size_phone.defualtsize!*3
                        ,left:size_phone.defualtsize!*3),
                    child:Formregister(),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size_phone.defualtsize!*3),
                        boxShadow: [
                          BoxShadow(
                              color: ColorForm.withOpacity(.3),
                              blurRadius: 10,
                              spreadRadius: 5
                          )
                        ]

                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if(downnload)  Container(
            color: Colors.grey.withOpacity(.1),
            height: size_phone.height,
            width: size_phone.width,
            child:LoadingOverlayPro(
                progressIndicator: LoadingBouncingLine.circle(
                  backgroundColor: Colors.white,
                  borderColor: Colors.white,
                ),
                isLoading: downnload, child: Text('')
            )
        ),
      ],
    );
  }


  Form Formregister() {
    return  Form(
      key: _key,
      child: Column(
        children: [
          Spacer(),
          Text('  انشاء حساب',style: TextStyle(color: Colors.black,fontFamily: 'header',fontWeight: FontWeight.bold,fontSize: 20)),
          textfield('ادخل الايميل', Icons.email_outlined,Email),
          textfield('ادخل  كلمة  السر', Icons.remove_red_eye_outlined,password),
          textfield('اعد إدخال كلمة سرك', Icons.remove_red_eye_outlined,passwordRet),
          Customer_config.CustomerButton('انشاء ',ColorForm,Colors.white,size_phone.defualtsize!*2,size_phone.defualtsize!*10,(){
            if(_key.currentState!.validate()){
              setState(() {
                downnload=true;
              });
              auth.SignUpAlert(context,Email.text, password.text,(){
                Navigator.pushNamed(context, RouteNames.home);}).whenComplete((){
                setState(() {
                  downnload=false;
                });
              });


            }
          }),
       Spacer(),
           Wrap(
                children: [
                  Text(' لديك حساب؟',style:  TextStyle(fontSize: 22,fontFamily: 'body',fontWeight:FontWeight.bold,color:
                  ColorForm),),
                  GestureDetector(
                      onTap: (){Navigator.of(context).pushNamed('login');}, child:
                  Text('تسحيل دخول ',style:TextStyle(fontSize: 20,fontFamily: 'body',fontWeight:FontWeight.bold,color:
    Colors.black.withOpacity(.7)),)),





                ]),

        ],
      ),
    );
  }
  Container textfield(String title,IconData icon,TextEditingController controller){
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size_phone.defualtsize!*10),
      ),
      padding: EdgeInsets.only(left: size_phone.defualtsize!*6.5,
          right:  size_phone.defualtsize!*6.5,
          bottom:  size_phone.defualtsize!*2),
      child:TextFormField(

          obscureText:controller==Email?false:true,
          keyboardType: controller==Email?TextInputType.text:TextInputType.visiblePassword,
        controller: controller,
          onSaved: (val){
          controller.text=val!;
          },
          validator: (val){
          if(controller==Email){
            if(Email.text.isEmpty)
              return "الحقل مطلوب";
            else if(!RegExp(validEmail).hasMatch(Email.text))
              return "يجب ان يكون بصيغة a@gmail.com";
          }
          else if(controller==password){
            if(password.text.isEmpty)
              return "الحقل مطلوب";
            else if(password.text.length!=6&&password.text.isNumericOnly)
              return "يجب ان تحتوي على 6 ارقام او احرف";
          }
          else if(controller==passwordRet){
            if(passwordRet.text.isEmpty)
              return "الحقل مطلوب";
            else
            if(passwordRet.text!=password.text&&!password.text.isEmpty)
              return "غير مطابقة";
          }


          },
          decoration:InputDecoration(
            errorBorder: border(),
            focusedBorder: border(),
            floatingLabelStyle:TextStyle(fontSize: 20,fontFamily: 'body',fontWeight:FontWeight.normal,color:
            Colors.white),
            filled: true,
            fillColor: ColorForm,

            prefixIcon:Icon(color: Colors.white,icon),
            hintText: title,
            hintStyle: TextStyle(fontSize: 20,fontFamily: 'body',fontWeight:FontWeight.bold,color:
            Colors.white),
            focusColor: Color.fromRGBO(242, 246, 246, 1.0),
            disabledBorder:border(),
            enabledBorder: border(),
            border: border(),

          )
      ),
    );
  }
  border(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(size_phone.defualtsize!*10),
        borderSide: BorderSide(
          color:   ColorForm,

        )
    );
  }
}



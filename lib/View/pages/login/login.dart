
import 'package:admaindashboard/Controller/Auth_controller/Auth_Controller.dart';
import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'package:get/get.dart';
class login extends StatefulWidget {

  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => loginState();
}

class loginState extends State<login> {
  TextEditingController Email =TextEditingController();
  TextEditingController password =TextEditingController();
  GlobalKey<FormState> _key=GlobalKey<FormState>();
  Auth_Controller auth=Auth_Controller();
  bool downnload=false;
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
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
                  height:size_phone.defualtsize!*30 ,
                    width: size_phone.defualtsize!*40,
                    margin: EdgeInsets.only(right:size_phone.defualtsize!*3
                        ,left:size_phone.defualtsize!*3),
                    child:FormLogin(),
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
     ] );
  }

  Form FormLogin() {
    return  Form(
      key: _key,
      child: Column(
        children: [

          Spacer(),
          Text('  تسجيل الدخول',style: TextStyle(color: Colors.black87,fontFamily: 'header',fontWeight: FontWeight.bold,fontSize: 20)),
          textfield('أدخل  الايميل', Icons.email_outlined,Email),
          textfield('أدخل  كلمة  السر', Icons.remove_red_eye_outlined,password),
          Customer_config.CustomerButton('دخول ',ColorForm,Colors.white,size_phone.defualtsize!*3,size_phone.defualtsize!*10,
                  ()async{

            if(_key.currentState!.validate()){

              setState(() {
                downnload=true;
              });
          await auth.LoginAlert(context,Email.text, password.text).whenComplete(
              (){
                setState(() {
                  downnload=false;
                });
              }
          );

           }
          }),
          Spacer(),
          Wrap(
              children: [
                Text(' ليس لديك حساب؟',style: TextStyle(fontSize: 22,fontFamily: 'body',fontWeight:FontWeight.bold,color:
                ColorForm),),
                GestureDetector(  onTap: (){
                  Navigator.of(context).pushNamed(RouteNames.register);
                },
                    child: Text('  انشاء حساب',style:TextStyle(fontSize: 20,fontFamily: 'body',fontWeight:FontWeight.bold,color:
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
      child: TextFormField(

          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            }
            else if(controller==password){
              if(password.text.isEmpty)
                return "الحقل مطلوب";}


          },
          decoration: InputDecoration(
            errorBorder: border(),
            focusedBorder: border(),
            floatingLabelStyle:TextStyle(fontSize: 20,fontFamily: 'body',fontWeight:FontWeight.normal,color:
            Colors.white),
            filled: true,
              fillColor:  Colors.white,

              prefixIcon:Icon(color: ColorForm,icon),
              hintText: title,
              hintStyle: TextStyle(fontSize: 20,fontFamily: 'body',fontWeight:FontWeight.bold,color:
              ColorForm),
              focusColor: ColorForm,
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



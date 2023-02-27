import 'package:admaindashboard/Controller/Auth_controller/Auth_Controller.dart';
import 'package:admaindashboard/Model/analysis_model/analysis.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/page_titles.dart';
import '../../widgets/app_scaffold.dart';
class user_display extends StatefulWidget {
  const user_display({Key? key}) : super(key: key);

  @override
  State<user_display> createState() => _user_displayState();
}

class _user_displayState extends State<user_display> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  final _store=FirebaseFirestore.instance.collection("user");

  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: AppScaffold(
        pageTitle: PageTitles.home,
        body:
      Scaffold(
      backgroundColor: backgroundColor,
        body:Stack(
          textDirection: TextDirection.rtl,
          children: [
            SingleChildScrollView(
              child: Column(
              children: [
                 Container(
                   margin: EdgeInsets.only(top: 30),
                   height: size_phone.height,
                   child: StreamBuilder(
                     stream: _store.snapshots(),
                       builder: (context,snapshots){
                       if(snapshots.hasData)
                         return ListViewUser(snapshots);
                       else
                         return Align(
                           alignment: Alignment.topCenter,
                           child: CircularProgressIndicator(
                             color: ColorForm,
                             strokeWidth: 4,
                           ),
                         );

                       },
                   ),
                 ),

              ],
      ),
            ),
            Container(
              color: ColorForm.withOpacity(.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("المستخدم",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.black),),

                  Text("كلمه السر",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color:  Colors.black),),

                  if(size_phone.width!>850) Text("تاريخ انشاء الحساب",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color:  Colors.black),),

                  Text("",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color:  Colors.black.withOpacity(.8)),),
                ],
              ),
            ),
            
          ],
        )
      )
    ));
  }
}

ListViewUser(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
  return ListView.separated(
    separatorBuilder: (BuildContext context, int index) {
      return Container(
        color: Colors.white,
        height: size_phone.defualtsize!*2,
      );
    },
    itemBuilder: (BuildContext context, int index) {
      analysis_model.user= snapshots.data!.docs.length;
      var data=snapshots.data!.docs[index].data();
      return Container(
        height: size_phone.defualtsize!*3,
        decoration: BoxDecoration(
          color: ColorForm,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3,3),
              spreadRadius: 5,
              blurRadius: 10
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           Text(data['email'],style: Text_Style().StyleFount(size: 16, fountFamily: "tahome", color: Colors.white),),
           VerticalDivider(),
          Text(data['password'],style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.white),),
            VerticalDivider(),
            if(size_phone.width!>850)Text(data['password'],style: Text_Style().StyleFount(size: 20, fountFamily: "body", color:  Colors.white),),
            if(size_phone.width!>850) VerticalDivider(),
            Customer_config.CustomerButton("حذف",
                Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!*3.5, () {
                  Auth_Controller().deleteUser(snapshots.data!.docs[index].id,context);
                })
          ],
        ),
      );
    },
    itemCount: snapshots.data!.docs.length,);
}

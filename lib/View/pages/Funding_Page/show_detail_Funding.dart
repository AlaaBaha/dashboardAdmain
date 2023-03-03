
import 'package:admaindashboard/Controller/Fundind_controller.dart';
import 'package:admaindashboard/Controller/cource_controller/AddCourse_controller.dart';
import 'package:admaindashboard/View/constants/page_titles.dart';
import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/View/widgets/app_scaffold.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/alert.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
class show_detail_funding extends StatefulWidget {
  static String fundingID="";
  show_detail_funding();

  @override
  State<show_detail_funding> createState() => show_detail_fundingeState();
}

class show_detail_fundingeState extends State<show_detail_funding> {
  bool downnload=false;
  @override
  Widget build(BuildContext context) {

    size_phone().init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppScaffold(
              pageTitle: PageTitles.detail_funding,
              body:Stack(
                children: [
                  SingleChildScrollView(
                child: Container(
                  color: backgroundColor,
                  child:show_detail_funding.fundingID.isEmpty?
                  Container():
                  StreamBuilder(
                    stream: funding_controller().getFundingDetail(show_detail_funding.fundingID!),
                    builder: (context,snapshots){
                      if(snapshots.hasData)
                        return ListFunding(snapshots,context);
                      else
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorForm,
                            strokeWidth: 4,
                          ),
                        );

                    },
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
     ] ),
    ));
  }
  ListFunding(snapshots,BuildContext context) {
    var data=snapshots.data!.data();
    return Center(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child:Container(
          padding: EdgeInsets.only(top:size_phone.defualtsize!*2,right:10),
          margin: EdgeInsets.only(top:size_phone.defualtsize!*5 ),
          height: size_phone.defualtsize!*30,
          width: size_phone.defualtsize!*30,
          decoration: BoxDecoration(
              color: ColorForm.withOpacity(.8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              detailitem("  الطلب من الايميل  :",data['email_user']),
              detailitem("  الاسم  :",data['nameuser']),
              Row(children: [
                detailitem("  اثبات الشخصية للمستخدم ؟  :",""),
                Builder(
                  builder: (BuildContext context) { return IconButton(onPressed: () {     funding_controller().openLink(data["provFile"]);},
                    icon: Icon(Icons.download,color: Colors.white,),tooltip:"قم بتحميل الملف " ,); },),


              ],),
              detailitem("  مبلغ التمويل  :",data['price_Fun'].toString()),
              Column(
                children: [
                  Text(" تفاصيل المشروع:",style: Text_Style().StyleFount(size:22, fountFamily: "body", color: Colors.black),),
                  Container(
                      height: size_phone.defualtsize!*10,
                      width: size_phone.defualtsize!*25,
                      child: Text(data['describe'],style: Text_Style().StyleFount(size:19, fountFamily: "tahmoe", color: Colors.black87),)),

                ],),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Customer_config.CustomerButton("موافقة",
                  Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!!*4.5, () {
                Alert_Config().Alert(fun: (){
                  Navigator.popAndPushNamed(context, RouteNames.Funding);
                  AddCourse_controller().EmailOpen(data['email_user'],'لقد تم الموافقة علي طلب تمويلك   قم بالتواصل معنا علي رقم  0987654321').whenComplete((){
                    funding_controller().DeleteFunding(snapshots.data!.id, context);
                  });
                }, context: context, title: "هل تريد الموافقة على الطلب", type: CoolAlertType.warning);
              }),
                  Customer_config.CustomerButton("رفض",
                      Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!*4.5, () {
                        Alert_Config().Alert(fun: (){
                          Navigator.popAndPushNamed(context, RouteNames.Funding);
                          AddCourse_controller().EmailOpen(data['email_user'],'لقد رفض  طلب تمويلك  ').whenComplete((){
                            funding_controller().DeleteFunding(snapshots.data!.id, context);
                          });
                        }, context: context, title: "هل تريد رفض الطلب", type: CoolAlertType.warning);

                      }),
                ],),
              Spacer(),
            ],
          ),)
        )
      );

  }

  detailitem(String text,String val){
    return  Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(text,style: Text_Style().StyleFount(size:22, fountFamily: "body", color: Colors.black),),
        Text(val,style: Text_Style().StyleFount(size:20, fountFamily: "body", color: Colors.black87),),
      ],);
  }
}



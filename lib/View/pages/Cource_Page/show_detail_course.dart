
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
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
class show_detail_course extends StatefulWidget {
  static String? courseID;
   show_detail_course();

  @override
  State<show_detail_course> createState() => _show_detail_courseState();
}

class _show_detail_courseState extends State<show_detail_course> {
  bool downnload=false;
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          AppScaffold(
              pageTitle: PageTitles.detail_course,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: backgroundColor,
                      child: show_detail_course.courseID==null?
                      Container():StreamBuilder(
                        stream: AddCourse_controller().getCourseDetail(show_detail_course.courseID!),
                        builder: (context,snapshots){
                          if(snapshots.hasData&&!snapshots.data!.isNull)
                            return ListCourseDital(snapshots,context);
                          else if(show_detail_course=="")
                            return Container();
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
                  ],
                ),
              )),
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
      ),
    );
  }
  ListCourseDital(snapshots,BuildContext context) {
    var data=snapshots.data!.docs[0].data();
    var length=snapshots.data!.docs.length;
    if(length>0)

      return Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.only(top:size_phone.defualtsize!*5 ),
            height: size_phone.defualtsize!*20,
            width: size_phone.defualtsize!*30,
            decoration: BoxDecoration(
                color: ColorForm
            ),
            child: Column(
              children: [
                detailitem("  الطلب من الايميل  :",data['User_Email']),
                detailitem("  تصنيف طلب التدريب  :",data['catalog']),
                Column(children: [
                  Text(" توضيح لما يحتاجة من كورس للتدريب",style: Text_Style().StyleFount(size:size_phone.defualtsize!*1.3, fountFamily: "body", color: Colors.black),),
                  Container(
                      height: size_phone.defualtsize!*10,
                      width: size_phone.defualtsize!*25,
                      child: Text(data['think'],style: Text_Style().StyleFount(size:size_phone.defualtsize!*1.3, fountFamily: "body", color: Colors.white),)),

                ],),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Customer_config.CustomerButton("موافقة",
                        Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!!*4.5, () {
                          Alert_Config().Alert(fun: (){
                            Navigator.pop(context);
                            setState(() {
                              downnload=true;
                            });

                            AddCourse_controller().EmailOpen("alaaazhari16@gmail.com",'لقد تم الموافقة علي طلب كورس تدريب ${data['catalog']} قم بالدخول  الي  الكورسات في الموقع').whenComplete((){
                              Navigator.popAndPushNamed(context, RouteNames.Request_Course);
                              AddCourse_controller().DeleteCourse(snapshots.data!.docs[0].id, context);
                            });
                          }, context: context, title: "هل تريد الموافقة على الطلب", type: CoolAlertType.warning);
                        }),
                    Customer_config.CustomerButton("رفض",
                        Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!*4.5, () {
                          Alert_Config().Alert(fun: (){
                            Navigator.pop(context);
                          setState(() {
                            downnload=true;
                          });
                            AddCourse_controller().EmailOpen("alaaazhari16@gmail.com",'لقد تم الرفض علي طلب كورس تدريب ${data['catalog']}قم بادخال البيانات الصحيحة').whenComplete((){
                              Navigator.popAndPushNamed(context, RouteNames.Request_Course);
                              AddCourse_controller().DeleteCourse(snapshots.data!.docs[0].id, context);
                            });
                          }, context: context, title: "هل تريد رفض الطلب", type: CoolAlertType.warning);

                        }),
                  ],),
                Spacer(),
              ],
            ),),



        ),
      );
    return Container();

  }

  detailitem(String text,String val){
    return  Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(text,style: Text_Style().StyleFount(size:size_phone.defualtsize!*1.5, fountFamily: "body", color: Colors.black),),
        Text(val,style: Text_Style().StyleFount(size:size_phone.defualtsize!*1.4, fountFamily: "body", color: Colors.white),),
      ],);
  }
}



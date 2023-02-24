
import 'package:admaindashboard/Controller/cource_controller/AddCourse_controller.dart';
import 'package:admaindashboard/Model/analysis_model/analysis.dart';
import 'package:admaindashboard/View/constants/page_titles.dart';
import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/pages/Cource_Page/show_detail_course.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/View/widgets/app_scaffold.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Request_Course extends StatefulWidget {
  const Request_Course({Key? key}) : super(key: key);

  @override
  State<Request_Course> createState() => _Request_CourseState();
}

class _Request_CourseState extends State<Request_Course> {
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: AppScaffold(
          pageTitle: PageTitles.Request_Course,
          body: SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child: Column(
                children: [
                 Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     VerticalDivider(thickness: 3,width: 3,),
                   Text("تصنيف الكورس",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.black),),
                   VerticalDivider(thickness: 3,width: 3,),
                   Text("طالب الكورس",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.black),),
                 ],),
                  Container(
                    height: size_phone.height,
                    child: StreamBuilder(
                      stream: AddCourse_controller().All_Reuest,
                      builder: (context,snapshots){
                        if(snapshots.hasData)

                          return ListRequestCourse(snapshots);
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
                  )

                  // ListViewUser()
                ],
              ),
            ),
          )),
    );
  }
  ListRequestCourse( snapshots) {
    analysis_model.Cour= snapshots.data!.docs.length;
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          height: size_phone.defualtsize!*2,

        );
      },
      itemBuilder: (BuildContext context, int index) {
        var data=snapshots.data!.docs[index].data();
        return Container(

          height: size_phone.defualtsize!*4,
          decoration: BoxDecoration(
              color: ColorForm,
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(-3,3),
                    spreadRadius:1,
                    blurRadius:1
                )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          Text(data['catalog'],style: Text_Style().StyleFount(size: size_phone.defualtsize!*1.5, fountFamily: "body", color: Colors.white),),
          Text(data['User_Email'],style: Text_Style().StyleFount(size: size_phone.defualtsize!*1.5, fountFamily: "body", color: Colors.white),),
          Customer_config.CustomerButton("عرض",
            Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!!*3.5, () {
              show_detail_course.courseID= data['think'];
          Navigator.pushNamed(context,   RouteNames.detail_Course);
            })
            ],)
          );
      },
      itemCount: snapshots.data!.docs.length,);
  }
}

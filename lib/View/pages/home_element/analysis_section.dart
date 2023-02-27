
import 'package:admaindashboard/Controller/home_controller/Anaysis_Controller.dart';
import 'package:admaindashboard/Model/analysis_model/analysis.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../Controller/cource_controller/AddCourse_controller.dart';
import '../../widgets/Text_Style.dart';
class analysis_section extends StatefulWidget {
  const analysis_section({Key? key}) : super(key: key);

  @override
  State<analysis_section> createState() => _analysis_sectionState();
}

class _analysis_sectionState extends State<analysis_section> {

  double tempuser= analysis_model.user  as double;
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    print(size_phone.width);
   return  Scaffold(
     backgroundColor: Colors.white,
      body: Column(
          children: [
       Expanded(child: Row(children: [
         detailChart("product","عدد المنتجات"),
         detailChart("user","عدد المستخدمين")
       ],)),
            Expanded(child: Row(children: [
              detailChart("Request_Funding","طلبات التمويل "),
              detailChart("RequestTraining","طلبات التسويق")
            ],)),
          ],


        ),

    );
  }
  detailChart(String NameDB,String title){//"product"
    return  Expanded(
      child: Column(
        children: [StreamBuilder(
            stream:FirebaseFirestore.instance.collection(NameDB).snapshots(),
            builder: (context,snapshots){
              if(snapshots.hasData)
                return Container(
                  margin: EdgeInsets.only(top:  size_phone.defualtsize!*2,right:  size_phone.defualtsize!*3,left:  size_phone.defualtsize!*1,
                  bottom:  size_phone.defualtsize!*1),
                  padding: EdgeInsets.all( size_phone.defualtsize!*1),
                  height: size_phone.defualtsize!*10,
                  width: size_phone.defualtsize!*20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( size_phone.defualtsize!*1),
                      color: ColorForm,
                      boxShadow: [BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1,3),
                        spreadRadius: 5,
                        blurRadius: 10
                      )]
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title,style: Text_Style().StyleFount(size: size_phone.defualtsize!*2, fountFamily: "body", color: Colors.white),)

                          ],),
SizedBox(width: size_phone.defualtsize!*3.5,),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text((snapshots.data!.docs.length).toString(),style: Text_Style().StyleFount(size: size_phone.defualtsize!*5, fountFamily: "body", color: Colors.white),)


                            ]),
                      ],
                    ),
                  ),
                );
              else
                return Center(child:  CircularProgressIndicator(
                  strokeWidth: 4,
                  color: ColorForm,
                ));
            })],
      ),
    );
  }
  pieDetail(double val,IconData icon,Color color,){
    return PieChartSectionData(
        value:val ,
        color: color,
    badgeWidget: Icon(icon),
    radius: 50,
    );
  }
}

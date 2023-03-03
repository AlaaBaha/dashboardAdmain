
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

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    print(size_phone.width);
   return  Scaffold(
     backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size_phone.defualtsize!*2,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [ detailChart("Request_Funding","طلبات التمويل ",colorsFunding,Icons.monetization_on),
                  SizedBox(width: size_phone.defualtsize!*4,),
                  detailChart("RequestTraining","طلبات التدريب",ColorCourse,Icons.add_box_sharp),],),

              SizedBox(height: size_phone.defualtsize!*1,),
       Row(mainAxisAlignment: MainAxisAlignment.center,
         children: [     detailChart("product","عدد المنتجات",ColorProduct,Icons.shopping_cart),
           SizedBox(width: size_phone.defualtsize!*4,),
        detailChart("user","عدد المستخدمين",ColorForm,Icons.person),]),


              SizedBox(height:20,),
              Align(
                alignment: Alignment.bottomRight,
                child:    SizedBox(
                    child:
                    Padding(
                      padding:  EdgeInsets.only(right: 50),
                      child: Column(
                        children: [
                          detatilPie("طلبات التمويل ",Icons.monetization_on),
                          detatilPie("طلبات التدريب",Icons.add_box_sharp),
                          detatilPie("عدد المنتجات",Icons.shopping_cart),
                          detatilPie("عدد المستخدمين",Icons.person),
                        ],
                      ),
                    )),
              ),

            ],


          ),
      ),

    );
  }
  detailChart(String NameDB,String title,Color color,IconData icon){//"product"
    return  StreamBuilder(
        stream:FirebaseFirestore.instance.collection(NameDB).snapshots(),
        builder: (context,snapshots){
          if(snapshots.hasData)
            return Container(
             margin: EdgeInsets.only(top:  size_phone.defualtsize!*.2,right:  size_phone.defualtsize!*.3,left:  size_phone.defualtsize!*.1,
              bottom:  size_phone.defualtsize!*.1),
              padding: EdgeInsets.all( size_phone.defualtsize!*1),
              height: size_phone.defualtsize!*10,
              width: size_phone.defualtsize!*10,
child: PieChart(
  PieChartData(
    pieTouchData: PieTouchData(
      touchCallback: (FlTouchEvent event, pieTouchResponse){
            setState(() {
            if (!event.isInterestedForInteractions ||
            pieTouchResponse == null ||
            pieTouchResponse.touchedSection == null) {
            touchedIndex = -1;
            return;
            }
            touchedIndex = pieTouchResponse
                .touchedSection!.touchedSectionIndex;
            });
      },
      enabled: true,

    ),
      sections: [PieChartSectionData(
        titleStyle: Text_Style().StyleFount(size: 30, fountFamily: "body", color: Colors.white,),
        radius:size_phone.defualtsize!*5 ,
        badgeWidget: Icon(icon,color: Colors.white,size: 27,),
        badgePositionPercentageOffset: .008,
        color: color,
          title:(snapshots.data!.docs.length ).toString(),value:snapshots.data!.docs.length as double )]
    // read about it in the PieChartData section
  ),
  swapAnimationDuration: Duration(milliseconds: 150), // Optional
  swapAnimationCurve: Curves.linear, // Optional
)
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular( size_phone.defualtsize!*1),
//                   color: Colors.white,
//                   boxShadow: [BoxShadow(
//                     color: Colors.black26.withOpacity(.1),
//                     offset: Offset(1,3),
//                     spreadRadius: 5,
//                     blurRadius: 10
//                   )]
//               ),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(width: size_phone.defualtsize!*5,),
//                         Text(title,style: Text_Style().StyleFount(size: size_phone.defualtsize!*2, fountFamily: "body", color:ColorForm),)
//
//                       ],),
// SizedBox(width: size_phone.defualtsize!*10,),
//                     Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text((snapshots.data!.docs.length).toString(),style: Text_Style().StyleFount(size: size_phone.defualtsize!*2, fountFamily: "body", color: ColorForm),)
//
//
//                         ]),
//                   ],
//                 ),
//               ),

            );
          else
            return Center(child:  CircularProgressIndicator(
              strokeWidth: 4,
              color: ColorForm,
            ));
        });
  }

  detatilPie(text,IconData icon) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width:10,),
        Text(text,style:Text_Style().StyleFount(size: size_phone.defualtsize!*1.5, fountFamily: "body", color:ColorForm)),
      ],
    );
  }

}

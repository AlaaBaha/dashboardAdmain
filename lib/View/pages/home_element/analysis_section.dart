
import 'package:admaindashboard/Controller/home_controller/Anaysis_Controller.dart';
import 'package:admaindashboard/Model/analysis_model/analysis.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
      body: Container(
        child: GridView(
          padding: EdgeInsets.all(size_phone.width!<=500?size_phone.defualtsize!*11:0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: size_phone.width!<=850?1:2,
          childAspectRatio:size_phone.width!<=500?0.7:1.5),
          children: [
            Container(
              width: size_phone.width!/2,
              child:  PieChart(
                  PieChartData(
                      centerSpaceRadius: 100,
                      centerSpaceColor:Colors.white,
                      borderData: FlBorderData(show: true),
                      sections: [
                        pieDetail(5, Icons.monetization_on,colorsFunding),
                        // pieDetail( 5,Icons.category,ColorCourse),
                        //  pieDetail( 5, Icons.shopping_cart,ColorProduct),
                        //  pieDetail(5, Icons.person,drawerColor),
                      ]))),
            Center(
                child:  Column(
                  children: [
Spacer(),
                    detailChart("          طلبات التمويل   ",Icons.monetization_on,colorsFunding,analysis_model.Fund),
                    detailChart("          طلبات التدريب   ",Icons.category,ColorCourse,analysis_model.Cour),
                    detailChart("عدد المنتجات المنصة   ",Icons.shopping_cart,ColorProduct,analysis_model.prod),
                    detailChart("عدد مستخدمين النظام   ",Icons.person,ColorUser, analysis_model.user),
                    Spacer(),
                  ],
                )),
          ],


        ),
      ),
    );
  }
  detailChart(String text,IconData icon,Color color,int num){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(icon,color: color,),
      Text(text,style: Text_Style().StyleFount(size: 25, fountFamily: "body", color: ColorUser),),
        Text(num.toString(),style: Text_Style().StyleFount(size: 25, fountFamily: "body", color: ColorUser),),

    ],);
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

import 'package:admaindashboard/Controller/Fundind_controller.dart';
import 'package:admaindashboard/Model/analysis_model/analysis.dart';
import 'package:admaindashboard/View/constants/page_titles.dart';
import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/pages/Funding_Page/show_detail_Funding.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/View/widgets/app_scaffold.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:flutter/material.dart';
class Funding extends StatefulWidget {
  const Funding({Key? key}) : super(key: key);

  @override
  State<Funding> createState() => _FundingState();
}

class _FundingState extends State<Funding> {
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: AppScaffold(
          pageTitle: PageTitles.Funding,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top:30),
                  color: backgroundColor,
                  child: Column(
                    children: [
                      Container(
                        height: size_phone.height,
                        child: StreamBuilder(
                          stream: funding_controller().Allfunding_Request,
                          builder: (context,snapshots){
                            if(snapshots.hasData)
                              return ListRequestfunding(snapshots);
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
              ),
              Container(
                color: ColorForm.withOpacity(.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Text("طالب التمويل ",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.black),),
                    Text("قيمة التمويل",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.black),),
                    Text("تفاصيل",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.black),),


                  ],
                ),
              ),
            ],
          )),
    );
  }
  ListRequestfunding( snapshots) {

    analysis_model.Fund=snapshots.data!.docs.length;
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
                Text(data['nameuser'],style: Text_Style().StyleFount(size: size_phone.defualtsize!*1.3, fountFamily: "body", color: Colors.white),),
                Text(data['price_Fun'].toString(),style: Text_Style().StyleFount(size: size_phone.defualtsize!*1.3, fountFamily: "body", color: Colors.white),),
                Customer_config.CustomerButton("عرض",
                    Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!!*3.5, () {
                      show_detail_funding.fundingID= data['fun_id'];
                      Navigator.pushNamed(context,   RouteNames.detail_funding);
                    })
              ],)
        );
      },
      itemCount: snapshots.data!.docs.length,);
  }
}


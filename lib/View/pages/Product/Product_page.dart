import 'package:admaindashboard/Controller/Product_controller/product_controller.dart';
import 'package:admaindashboard/Model/analysis_model/analysis.dart';
import 'package:admaindashboard/View/constants/page_titles.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/View/widgets/app_scaffold.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:flutter/material.dart';
class Product_page extends StatefulWidget {
  const Product_page({Key? key}) : super(key: key);

  @override
  State<Product_page> createState() => _Product_pageState();
}

class _Product_pageState extends State<Product_page> {
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: AppScaffold(
          pageTitle: PageTitles.Product,
          body: SingleChildScrollView(
            child:Container(
              color: backgroundColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      VerticalDivider(thickness: 3,width: 3,),
                      Text("",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.black),),
                      VerticalDivider(thickness: 3,width: 3,),
                      Text("اسم المنتج",style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.black),),
                      if(size_phone.width!>900)VerticalDivider(thickness: 3,width: 3,),
                      if(size_phone.width!>900) Text("مالك المنتج",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.black),),
                      if(size_phone.width!>900)VerticalDivider(thickness: 3,width: 3,),
                      if(size_phone.width!>900)Text("تصنيف المنتج",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.black),),
                      if(size_phone.width!>900)VerticalDivider(thickness: 3,width: 3,),
                      Text("سعرالمنتج",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.black),),
                      VerticalDivider(thickness: 3,width: 3,),
                      Text("",style: Text_Style().StyleFount(size: 20, fountFamily: "body", color: Colors.black),),
                      VerticalDivider(thickness: 3,width: 3,),
                    ],
                  ),
                  Container(
                    height: size_phone.height,
                    child: StreamBuilder(
                      stream:product_controller().AllProduct,
                      builder: (context,snapshots){
                        if(snapshots.hasData)
                          return ListProduct(snapshots);
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
  ListProduct( snapshots) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          height: size_phone.defualtsize!*2,

        );
      },
      itemBuilder: (BuildContext context, int index) {
        analysis_model.prod=snapshots.data!.docs.length;
        var data=snapshots.data!.docs[index].data();
        return Container(

            height: size_phone.defualtsize!*5,
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
                Card(child: Image.network(data["ImgPath"],fit:BoxFit.fill,height:size_phone.defualtsize!*4 ,width: size_phone.defualtsize!*4,),),
                Text(data['namePro'],style: Text_Style().StyleFount(size:22, fountFamily: "body", color: Colors.white),),
               if(size_phone.width!>900) Text(data['userEmail'],style: Text_Style().StyleFount(size:22, fountFamily: "body", color: Colors.white),),
                Text(data['Catalog'].toString(),style: Text_Style().StyleFount(size: 22, fountFamily: "body", color: Colors.white),),
                if(size_phone.width!>900)  Text(data['price'].toString(),style: Text_Style().StyleFount(size:22, fountFamily: "body", color: Colors.white),),
                Customer_config.CustomerButton("حذف",
                    Colors.white, Colors.black, size_phone.defualtsize!*2, size_phone.defualtsize!!*3.5, () {
                      product_controller().Delete_Product(data['prod_id'], context);

                    })
              ],)
        );
      },
      itemCount: snapshots.data!.docs.length,);
  }
}

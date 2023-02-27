import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:flutter/material.dart';

import 'app_drawer.dart';
class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.body, required this.pageTitle, Key? key})
      : super(key: key);

  final Widget body;

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    size_phone().init(context);
    return Row(
      children: [
        if (!displayMobileLayout)
          const AppDrawer(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
    //           leading:Builder(
    //         builder: (BuildContext context) {
    // return TextButton(
    // tooltip: "", onPressed: () {  }, icon: null,
    // );}),
              // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
              automaticallyImplyLeading: displayMobileLayout,
              centerTitle: true,
              backgroundColor: ColorForm,
              title: Text(pageTitle,style: Text_Style().StyleFount(size:23,
                  fountFamily: "body", color: Colors.white),),
              iconTheme: IconThemeData(color:  Colors.white),
            ),
            drawer: displayMobileLayout
                ? const AppDrawer(
                    permanentlyDisplay: false,
                  )
                : null,
            body: body,
          ),
        )
      ],
    );
  }
}

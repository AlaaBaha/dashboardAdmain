import 'package:admaindashboard/View/pages/home_element/user_display.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:flutter/material.dart';

import '../../../config_Customer/Color.dart';
import '../../constants/page_titles.dart';
import '../../widgets/app_scaffold.dart';
import 'analysis_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: AppScaffold(
          pageTitle: PageTitles.home,
          body: SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child: Column(
                children: <Widget>[
                  Container(
                    height: size_phone.width!<=850?  size_phone.height!*1.3: size_phone.height!*.5,
                    width: size_phone.width,
                    child: analysis_section(),
                  ),
                  Container(
                    height: size_phone.height!/2,
                    width: size_phone.width,
                    child: user_display(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:admaindashboard/Controller/Auth_controller/Auth_Controller.dart';
import 'package:admaindashboard/View/widgets/Text_Style.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/ManageProvider/email.dart';
import '../../Model/Auth_Model/Auth_DB.dart';
import '../constants/page_titles.dart';
import '../constants/route_names.dart';
import 'app_route_observer.dart';
class AppDrawer extends StatefulWidget {
  const AppDrawer({required this.permanentlyDisplay, Key? key})
      : super(key: key);

  final bool permanentlyDisplay;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with RouteAware {
  String? _selectedRoute;
  AppRouteObserver? _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  Widget build(BuildContext context) {
   String? email=  email_Value.email;
    size_phone().init(context);
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: ColorForm,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      //padding: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('اهلا بك...', style: Text_Style().StyleFount(size: 23,
                          fountFamily: "header", color: Colors.white),),
                         Text(email!, style: Text_Style().StyleFount(size: 22,
                             fountFamily: "body", color: Colors.white),)
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: ColorForm,
                      ),
                    ),
                pageRoute(Icons.home, RouteNames.home,PageTitles.home),
                pageRoute(Icons.monetization_on, RouteNames.Funding,PageTitles.Funding),
                    pageRoute(Icons.add_box_sharp, RouteNames.Request_Course,PageTitles.Request_Course),

                    pageRoute(Icons.shopping_cart, RouteNames.Product,PageTitles.Product),
                pageRoute(Icons.category, RouteNames.Course,PageTitles.Course),
                pageRoute(Icons.person, RouteNames.user,PageTitles.user),

                    ListTileTheme(
                      iconColor: Color(0xffE7E7E7),
                      child: ListTile(
                        leading:  Icon(Icons.logout,size: 22,),
                        title:  Text(
                       "تسجيل خروج",
                          style: Text_Style().StyleFount(size: 22,
                            fountFamily: "body", color: Colors.white),
                        ),
                        onTap: () async {
                          Auth_Controller().LogoutAlert(context).whenComplete(() async {
                           // await _navigateTo(context, RouteNames.login);
                          });

                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
            if (widget.permanentlyDisplay)
              const VerticalDivider(
                width: 1,
              )
          ],
        ),
      ),
    );
  }
pageRoute(IconData icon,pagename, String pageTitles){
  return ListTileTheme(
            iconColor: Color(0xffE7E7E7),
            child: ListTile(
              title:Text(
                pageTitles,style: Text_Style().StyleFount(size:22,
                  fountFamily: "body", color: Colors.white),
              ),
              leading:  Icon(icon,size: 22,),
              onTap: () async {
                await _navigateTo(context, pagename);
              },
              selected: _selectedRoute ==pagename,
            ),
          );
}
 Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (widget.permanentlyDisplay) {
      Navigator.pop(context);
    }
    await Navigator.pushNamed(context, routeName);
  }

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context)!.settings.name;
    });
  }
}

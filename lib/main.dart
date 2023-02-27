import 'package:admaindashboard/View/constants/route_names.dart';
import 'package:admaindashboard/View/pages/Cource_Page/AddCourse.dart';
import 'package:admaindashboard/View/pages/Cource_Page/Request_Course.dart';
import 'package:admaindashboard/View/pages/Cource_Page/show_detail_course.dart';
import 'package:admaindashboard/View/pages/Funding_Page/Funding.dart';
import 'package:admaindashboard/View/pages/Funding_Page/show_detail_Funding.dart';
import 'package:admaindashboard/View/pages/Product/Product_page.dart';
import 'package:admaindashboard/View/pages/login/login.dart';
import 'package:admaindashboard/View/pages/login/register.dart';
import 'package:admaindashboard/View/widgets/app_route_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/pages/home_element/home_page.dart';
import 'View/pages/home_element/user_display.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAwwCZ7e455aZofqO817xotzQhtnyw9oUo"
        , appId:"1:1060213163950:web:8bdad6cbc338dffca9aa3f",
        messagingSenderId:  "1060213163950",
        projectId: "smallproduct-87765")
  );
  runApp(
      MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            floatingLabelStyle: TextStyle(color: Colors.white)
          )
        ),
        debugShowCheckedModeBanner: false,
    title: 'لوحة تحكم الادمن',
    initialRoute: RouteNames.login,
    navigatorObservers: [AppRouteObserver()],
    routes: {
      RouteNames.home: (_) => const HomePage(),
      RouteNames.Request_Course: (_) => const Request_Course(),
      RouteNames.Course: (_) => const Course(),
      RouteNames.Product: (_) => const Product_page(),
      RouteNames.Funding: (_) =>const Funding(),
      RouteNames.login: (_) => const login(),
      RouteNames.register: (_) => const register(),
      RouteNames.detail_Course: (_) =>  show_detail_course(),
      RouteNames.detail_funding: (_) =>  show_detail_funding(),
      RouteNames.user: (_) =>  user_display(),


    },
  ));
}


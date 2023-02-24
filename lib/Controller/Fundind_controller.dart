import 'package:admaindashboard/Model/funding_model/funding_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class funding_controller{
  var Allfunding_Request =funding_model().All_funding_Request;
  getFundingDetail(String id){
    return funding_model().getFundingDetail(id);
  }
  DeleteFunding(String id, BuildContext context){
    return funding_model().DeleteFunding(id);
  }
  Future<void> openLink(String link)async{
    Uri url=Uri.parse( link);
    if (await canLaunchUrl(url))
      await launchUrl(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }

}
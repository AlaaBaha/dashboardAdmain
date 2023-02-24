import 'package:cloud_firestore/cloud_firestore.dart';

class funding_model{
  final store=FirebaseFirestore.instance.collection("Request_Funding");
  get All_funding_Request{
    return store.snapshots();
  }

  getFundingDetail(String id)  {
    return  store.doc(id).snapshots();
  }
//data!.docs[0].data()
  DeleteFunding(String id) async {
    try{
      var temp=false;
      await store.doc(id).delete();
      return temp;
    }
    catch(e){
      return false;
    }
  }

}
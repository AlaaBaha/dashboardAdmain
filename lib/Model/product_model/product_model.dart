
import 'package:cloud_firestore/cloud_firestore.dart';

class product_model{
  final store=FirebaseFirestore.instance.collection("product");
  get All_Product{
    return store.snapshots();
  }
DeleteProduct(String ID_Product){
    return store.doc(ID_Product).delete();
}

}
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Course_detail.dart';
class AddCouse_model{
  final store=FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage? _storage;
  Future<bool> AddCouse({required String Name,required String catalog,required String nameFile,required Uint8List? ImgFile,
   required String linked})async{
    try {

      Reference reference=await firebase_storage.FirebaseStorage.instanceFor(bucket: "gs://smallproduct-87765.appspot.com").ref('Prov_user').child(nameFile);
      final UploadTask upload=reference.putData(ImgFile!);
      upload.whenComplete(()async{
       String imageUrl=await upload.snapshot.ref.getDownloadURL();
        final res = await store.collection('courses').doc();
       Course_detail details = new Course_detail(link: linked, catalog: catalog, Name: Name, image: imageUrl);
       await res.set(details.toMap());
        print('the fund success');
      });

      return true;
    }
    on FirebaseException catch(e){
      print('the fund fail');
      return false;
    }
  }
  get Request_Corse  {
    return  store.collection("RequestTraining").snapshots();
    
  }

  getCourseDetail(String id)  {
    return  store.collection("RequestTraining").where('think',isEqualTo: id).snapshots();
  }
//data!.docs[0].data()
  DeleteCourse(String id) async {
    try{
      var temp=false;
     await store.collection("RequestTraining").doc(id).delete();
      return temp;
    }
    catch(e){
      return false;
    }
  }
  get Catalog  {
    List<String>? temp=[];
    var store=  FirebaseFirestore.instance.collection("courses").get().then((event) {
      event.docs.forEach((e) {
        var data=e.data();
       if( !temp.contains(data["catalog"])) {
          temp!.add(data["catalog"]);
        }
      });
    });

    return temp;
  }
}

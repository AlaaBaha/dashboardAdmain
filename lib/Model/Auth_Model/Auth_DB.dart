import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'UserModel.dart';

class Auth_Model {
final _auth=FirebaseAuth.instance;
var process=false;

Timer? timer;
bool verficate=false;
 CollectionReference<Map<String, dynamic>> store= FirebaseFirestore.instance.collection("Admain");

Future<bool> deleteUser(String? email)async{
  try
  {
   await  FirebaseFirestore.instance.collection("user").doc(email).delete();
    return true;}
  catch(e){
    return false;
  }
}
Future<bool> log(String email, String password)async {
  UserModel mode =UserModel();
  try{
    bool check=false;
    var data;
 data=await store.where('email',isEqualTo: email).get().then((value) async {
   print(value.docs.length);
if(value.docs.length==1) {
  data = await value.docs[0].data();
  String temp=data['email'];
  print(temp);

  check=true;
}});

   return check;
    }

  on FirebaseException catch(e){
   return false;

  }}
Future<String> signUp(String email, String password)async {

  try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((uid) {
        setDetail(email,password);
     } );
        return "true";
    }
  on FirebaseException catch(e){

    return e.message!;
  }

}

setDetail(String email, String password) async{
  UserModel mode=UserModel();
  mode.email=email;
  mode.password=password;
  await store.doc(_auth.currentUser?.email).set(mode.toMap());
}
Future<bool> signOut(BuildContext context) async {
  try {
    await _auth.signOut();
    return true;

  } on FirebaseAuthException catch (e) {
    return false;
    // Displaying the error message
  }
}

}






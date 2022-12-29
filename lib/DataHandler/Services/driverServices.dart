import 'package:buraq_captain/DataHandler/Services/reception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AllScreens/driverInfoScreen.dart';
import '../../AllScreens/registerationScreen.dart';
import '../../AllWidgets/progressDialod.dart';
import '../Models/driver.dart';

class DriverServices{

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  static var value = 0.obs;

  var totalApprovedDrivers=0.obs;
  var totalUnApprovedDrivers = 0.obs;
  var totalDrivers=0.obs;
  var totalPendingDrivers = 0.obs;
  registerUser({required String name, required User user}) async {
    var x = CaptainModel(
        name: name,
        email: user.email!,
        type: "new",
        uid: user.uid,);
    try{
      await firestore.collection("captain").doc(user.uid).set(x.toJson()).then((value)
      {
        Get.snackbar('Done', 'Account Successfully created');
      Get.to(()=>DriverInfoScreen());});
    } catch (e) {
      Get.back();
    }
  }
  Stream<CaptainModel>? streamCaptain() {
    try {
      return firestore
          .collection("captain")
          .doc(auth.currentUser!.uid)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          return CaptainModel.fromJson(event.data()!);
        }
        return CaptainModel.fromJson(event.data()!);
      });
    } catch (e) {

      return null;
    }
  }

  Stream<List<CaptainModel>>? streamAllCaptains() {
    try {
      return firestore.collection("captain").snapshots().map((event) {

        List<CaptainModel> list = [];
        event.docs.forEach((element) {

          final admin = CaptainModel.fromJson(element.data());
            list.add(admin);
        });
        return list;
      });
    } catch (e) {
      return null;
    }
  }


  uploadImage(CaptainModel users,context) async {
    try {
      print("objectUID");
      print(users.uid);
      await firestore
          .collection("captain")
          .doc(users.uid)
          .update({"isVerified": true})
          .then((value) => displayToastMessage("The selected Captain is Approved", context))
          .onError((error, stackTrace) => displayToastMessage("Error $error", context));

      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
    }
  }

  deleteAccount(CaptainModel users,context) async {
    try {
      showDialog(context: context, builder: (ctx){
        return ProgressDialod(message: "Setting Users To Block Please wait",);
      });
      await firestore
          .collection("captain")
          .doc(users.uid).delete()
          .then((value) => displayToastMessage("Succefully deleted", context))
          .onError((error, stackTrace) => displayToastMessage("Error $error", context));
      Navigator.pop(context);

    } catch (e) {
      Navigator.pop(context);
    }
  }

  updateDetails(CaptainModel users,context,String? index,String? value) async {
    try {
      showDialog(context: context, builder: (ctx){
        return ProgressDialod(message: "Setting Users To Pending Please wait",);
      });
      // await FirebaseDatabase.instance.ref().child("captain").child(users.uid.toString()).update({"isPending": false});
      await firestore
          .collection("captain")
          .doc(users.uid)
          .update({"$index": '$value'}).then((value) => displayToastMessage("Successfully changed", context))
          .onError((error, stackTrace) => displayToastMessage("Error $error", context));

      Navigator.pop(context);

    } catch (e) {
      Navigator.pop(context);
    }
  }


}
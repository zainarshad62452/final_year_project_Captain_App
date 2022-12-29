import 'package:buraq_captain/AllScreens/loginScreen.dart';
import 'package:buraq_captain/AllScreens/mainscreen.dart';
import 'package:buraq_captain/AllScreens/pendingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Controllers/captain.dart';

class Reception {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  userReception() async {
    if(FirebaseAuth.instance.currentUser!=null){
      String type = await firestore
          .collection("captain")
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) => value['type'].toString());
      if(type == 'new'){
        Get.offAll(()=>PendingScreen());
      }else if(type=='captain'){
        Get.put(CaptainController());
        Get.offAll(()=>MainScreen());
      }else if(type == 'blocked'){
        Get.showSnackbar(GetSnackBar(title: "Your are blocked",));
      }else if( type == 'isPending'){
        Get.offAll(()=>PendingScreen());
      }
    }else{
      Get.offAll(()=>LoginScreen());
    }
  }
}

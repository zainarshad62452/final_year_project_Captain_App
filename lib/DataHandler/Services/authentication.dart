import 'package:buraq_captain/AllScreens/loginScreen.dart';
import 'package:buraq_captain/DataHandler/Services/reception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'driverServices.dart';

class Authentication {

  FirebaseAuth auth = FirebaseAuth.instance;
  createAccount(
      {required String name,
        required String email,
        required String pass,String? phone}) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (user.user != null) {
        DriverServices().registerUser(name: name, user: user.user!);

      } else {
        Get.snackbar('Error', 'Error');
      }
    } catch (e) {
      Get.snackbar('Error',e.toString().split(']').last);
      Get.back();
    }
  }

  signinWithEmail(String email, String pass) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        if (value.user != null) {
            Reception().userReception();
        } else {
          Get.snackbar('Error', 'Unknown Error');
        }
      });
    } catch (e) {
      Get.back();
       Get.snackbar('Error',e.toString().split(']').last);
    }
  }

  forgotPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      //TODO2 set email compariseon after setting up user controller
      await auth.sendPasswordResetEmail(email: email);

      Get.snackbar('Success', 'Password reset email sent to ${email}');
    } catch (e) {

      Get.snackbar('Error',e.toString().split(']').last);  //TODO3 firebase exception
    }
  }

  signOut() async {
    try {
      await auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar("Error Signing Out", e.toString()); //TODO4 firebase exception
    }
  }
}
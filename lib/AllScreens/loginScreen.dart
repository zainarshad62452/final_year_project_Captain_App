import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buraq_captain/AllScreens/pendingScreen.dart';
import 'package:buraq_captain/AllScreens/registerationScreen.dart';
import 'package:buraq_captain/AllWidgets/progressDialod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../DataHandler/Services/authentication.dart';
import '../main.dart';
import 'mainscreen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  static const String idScreen = "login";
  final Widget svg = SvgPicture.asset(
      'images/logosvgmain.svg',
      semanticsLabel: 'Acme Logo'
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 35.0,
                ),
                svg,
                // Image(
                //   image: AssetImage('images/logomain.png'),
                //   width: 390.0,
                //   height: 250.0,
                //   alignment: Alignment.center,
                // ),
                SizedBox(
                  height: 1.0,
                ),
                Text(
                    "Login as Captain",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0,fontFamily: "Brand-Bold"),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MaterialButton(
                        onPressed: (){
                  if(!emailTextEditingController.text.contains('@')) {
                    displayToastMessage("Email address is not Valid.", context);
                  }else if(passwordTextEditingController.text.isEmpty){
                    displayToastMessage("Password is Mandatory.", context);
                  }else{
                    // loginAndAuthenticateUser(context);
                    showDialog(context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return ProgressDialod(
                            message: "Authenticating, Please wait",
                          );
                        });
                    Authentication().signinWithEmail(emailTextEditingController.text.trim(), passwordTextEditingController.text.trim()).then(()=>Get.back());
                  }

                        },
                      color: Color(0xFFc6520a),
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Brand-Bold",
                            ),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                        ),
                  ],
                ),

                ),

                MaterialButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, RegisterationScreen.idScreen, (route) => false);
                    },
                    child: Text("Do not have a Account? Register Here"),),
                SizedBox(
                  width: 250.0,
                  child: TextLiquidFill(
                    loadUntil: 0.5,
                    loadDuration: Duration(seconds: 10),
                    text: 'BURAAQ',
                    waveColor: Color(0xFFc6520a),
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 300.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async{

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return ProgressDialod(
        message: "Authenticating, Please wait",
      );
    });
    final User? firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
      email:emailTextEditingController.text,
      password:passwordTextEditingController.text,).catchError((errMsg){
        Navigator.pop(context);
      displayToastMessage("Error:"+errMsg.toString(), context);
    })).user;


    if(firebaseUser!=null)//user
      {
        // goto(context,firebaseUser);
      userRef.child(firebaseUser!.uid).child("isVerified").onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if(data==true){
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("You are logged-in", context);

        }
      });
      userRef.child(firebaseUser.uid).child("isPending").onValue.listen((DatabaseEvent event) {
        final data2 = event.snapshot.value;
        if(data2==true){
          Navigator.pushNamedAndRemoveUntil(context, PendingScreen.idScreen, (route) => false);
          displayToastMessage("You are logged-in", context);
        }
      });
      userRef.child(firebaseUser.uid).child("isBlocked").onValue.listen((DatabaseEvent event) {
        final data2 = event.snapshot.value;
        if(data2==true){
          displayToastMessage("You are blocked by admin", context);
        }
      });
    }else{
      Navigator.pop(context);
      displayToastMessage("Error Occured! cannot signIn", context);
    }
  }

  // void goto(BuildContext context,User? firebaseUser){
  //   userRef.child(firebaseUser!.uid).child("isVerified").onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     if(data==true){
  //       Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
  //       displayToastMessage("You are logged-in", context);
  //
  //     }
  //   });
  //   userRef.child(firebaseUser.uid).child("isPending").onValue.listen((DatabaseEvent event) {
  //     final data2 = event.snapshot.value;
  //     if(data2==true){
  //       Navigator.pushNamedAndRemoveUntil(context, PendingScreen.idScreen, (route) => false);
  //       displayToastMessage("You are logged-in", context);
  //     }
  //   });
  //   userRef.child(firebaseUser.uid).child("isBlocked").onValue.listen((DatabaseEvent event) {
  //     final data2 = event.snapshot.value;
  //     if(data2==true){
  //       displayToastMessage("You are blocked by admin", context);
  //     }
  //   });
  // }
}

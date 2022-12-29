import 'package:buraq_captain/AllScreens/mainscreen.dart';
import 'package:buraq_captain/AllScreens/registerationScreen.dart';
import 'package:buraq_captain/configMaps.dart';
import 'package:buraq_captain/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../AllWidgets/progressDialod.dart';
import 'carInfoScreen.dart';
import 'loginScreen.dart';
class DriverInfoScreen extends StatelessWidget {
  static const String idScreen = "driverinfo";

  TextEditingController cnicNumberTextEditingController = TextEditingController();
  TextEditingController licenseNumberTextEditingController = TextEditingController();
  TextEditingController licenseCityTextEditingController = TextEditingController();
  TextEditingController expiryTextEditingController = TextEditingController();
  final Widget svg = SvgPicture.asset(
      'images/logosvgmain.svg',
      semanticsLabel: 'Acme Logo'
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 22.0,),
              svg,
              Padding(padding: EdgeInsets.fromLTRB(22.0,22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(height: 12.0,),
                    Text("Enter Driver Details",style: TextStyle(fontFamily: "Brand-Bold",fontSize: 24.0),),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: cnicNumberTextEditingController,
                      decoration: InputDecoration(
                        labelText: "CNIC Number",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: licenseNumberTextEditingController,
                      decoration: InputDecoration(
                        labelText: "License Number",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: licenseCityTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Liecnse City",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: expiryTextEditingController,
                      decoration: InputDecoration(
                        labelText: "License Expiry Date",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 42.0,
                    ),
                    MaterialButton(
                      onPressed: (){
                        if(cnicNumberTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter CNIC number", context);
                        }else if(licenseNumberTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter License number", context);
                        }else if(licenseCityTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter License City", context);
                        }else if(expiryTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter expiry date of License", context);
                        }else{
                          showDialog(context: context, builder: (ctx){
                            return ProgressDialod(message: "Adding Information! Please wait",);
                          });
                          saveDriverCarInfo(context);
                        }
                      },
                      color: Color(0xFFc6520a),
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Next",
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

            ],
          ),
        ),
      ),
    );
  }
  Future<void> saveDriverCarInfo(context) async {

    String userId =FirebaseAuth.instance.currentUser!.uid;
    print(userId);

    Map carInfoMap={
      "cnic-number":cnicNumberTextEditingController.text.trim(),
      "license_number":licenseNumberTextEditingController.text.trim(),
      "city-of-license":licenseCityTextEditingController.text.trim(),
      "expiry":expiryTextEditingController.text.trim(),
    };
    userRef.child(userId).child("driver_details").set(carInfoMap);
    final docUser = FirebaseFirestore.instance.collection("captain").doc(userId);
    Map<String, dynamic> toJson() =>
        {
          "cnic-number":cnicNumberTextEditingController.text.trim(),
          "license_number":licenseNumberTextEditingController.text.trim(),
          "city-of-license":licenseCityTextEditingController.text.trim(),
          "expiry":expiryTextEditingController.text.trim(),
        };
    await docUser.update(toJson());

    Navigator.pushNamedAndRemoveUntil(context, CarInfoScreen.idScreen, (route) => false);
  }
}

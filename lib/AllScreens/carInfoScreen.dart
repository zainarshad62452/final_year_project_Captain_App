import 'package:buraq_captain/AllScreens/mainscreen.dart';
import 'package:buraq_captain/AllScreens/pendingScreen.dart';
import 'package:buraq_captain/AllScreens/registerationScreen.dart';
import 'package:buraq_captain/DataHandler/Services/reception.dart';
import 'package:buraq_captain/configMaps.dart';
import 'package:buraq_captain/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../AllWidgets/progressDialod.dart';
import 'loginScreen.dart';
class CarInfoScreen extends StatelessWidget {
  static const String idScreen = "carinfo";

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  TextEditingController cartaxTextEditingController = TextEditingController();

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
                    Text("Enter Car Details",style: TextStyle(fontFamily: "Brand-Bold",fontSize: 24.0),),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: carModelTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Model",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: carNumberTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Registration Number",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: carColorTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Engine Number",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0,),

                    TextField(
                      controller: cartaxTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Tax Payment Date",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 42.0,
                    ),
                    MaterialButton(
                      onPressed: (){
                        if(carModelTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter car model", context);
                        }else if(carNumberTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter car registration number", context);
                        }else if(carColorTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter car engine number", context);
                        }else if(cartaxTextEditingController.text.isEmpty){
                          displayToastMessage("Please enter car Tax Payment date", context);
                        }
                        else{
                          showDialog(context: context, builder: (ctx){
                            return ProgressDialod(message: "Adding Car Informations! Please wait",);
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
                            "Submit",
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

    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map carInfoMap={
      "engine_number":carColorTextEditingController.text.trim(),
      "registration_number":carNumberTextEditingController.text.trim(),
      "car_model":carModelTextEditingController.text.trim(),
      "tax-payment":cartaxTextEditingController.text.trim(),
    };
    userRef.child(userId).child("car_details").set(carInfoMap);
    final docUser = FirebaseFirestore.instance.collection("captain").doc(userId);
    Map<String, dynamic> toJson() =>
        {
          "engine_number":carColorTextEditingController.text.trim(),
          "registration_number":carNumberTextEditingController.text.trim(),
          "car_model":carModelTextEditingController.text.trim(),
          "tax-payment":cartaxTextEditingController.text.trim(),
        };
    await docUser.update(toJson());
    displayToastMessage("Your request has been submitted. Please wait for Admin response", context);
    Reception().userReception();
  }
}

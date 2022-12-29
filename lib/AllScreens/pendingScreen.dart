import 'package:buraq_captain/DataHandler/Services/authentication.dart';
import 'package:buraq_captain/DataHandler/Services/reception.dart';
import 'package:flutter/material.dart';

import '../AllWidgets/progressDialod.dart';
class PendingScreen extends StatelessWidget {
 static const String idScreen = "pending screen";
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Your request is pending"),
            IconButton(onPressed: (){
              Authentication().signOut();
            }, icon: Icon(Icons.logout)),
            IconButton(onPressed: (){
              showDialog(context: context, builder: (ctx){
                return ProgressDialod(message: "Refreshing! Please wait",);
              });
              Reception().userReception();
            }, icon: Icon(Icons.refresh)),
          ],
        ),
      ),
          )),
    );
  }
}

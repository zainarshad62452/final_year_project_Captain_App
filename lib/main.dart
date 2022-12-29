import 'package:buraq_captain/AllScreens/loginScreen.dart';
import 'package:buraq_captain/AllScreens/registerationScreen.dart';
import 'package:buraq_captain/AllScreens/splashScreen.dart';
import 'package:buraq_captain/DataHandler/appData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'AllScreens/carInfoScreen.dart';
import 'AllScreens/driverInfoScreen.dart';
import 'AllScreens/mainscreen.dart';
import 'AllScreens/pendingScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.ref().child('captain');
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      create: (context)=>AppData(),
      child: GetMaterialApp(
        title: 'Buraaq Captain App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.idScreen,
        routes: {
          RegisterationScreen.idScreen:(context)=>RegisterationScreen(),
          LoginScreen.idScreen:(context)=>LoginScreen(),
          MainScreen.idScreen:(context)=>MainScreen(),
          SplashScreen.idScreen:(context)=> SplashScreen(),
          CarInfoScreen.idScreen:(context)=> CarInfoScreen(),
          DriverInfoScreen.idScreen:(context)=> DriverInfoScreen(),
          PendingScreen.idScreen:(context)=> PendingScreen(),

        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


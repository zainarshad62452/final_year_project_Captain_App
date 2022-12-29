import 'dart:async';
import 'package:buraq_captain/AllScreens/registerationScreen.dart';
import 'package:buraq_captain/AllScreens/searchScreen.dart';
import 'package:buraq_captain/AllWidgets/Divider.dart';
import 'package:buraq_captain/Assistants/assistantMethod.dart';
import 'package:buraq_captain/DataHandler/Controllers/captain.dart';
import 'package:buraq_captain/DataHandler/Services/authentication.dart';
import 'package:buraq_captain/DataHandler/appData.dart';
import 'package:buraq_captain/configMaps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  static const String idScreen = "mainscreen";
  static Rx<String> homeValue = 'Home'.obs;
  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geolocator = Geolocator();

  double bottomPaddingOfMap =0;
  void locatePosition() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        currentPosition = position;
        LatLng latLngPosition = LatLng(position.latitude, position.longitude);
        CameraPosition cameraPosition = new CameraPosition(target: latLngPosition,zoom: 14);
        newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      } on Exception catch (e) {
        print(e);
      }
    } else {
      await Geolocator.requestPermission();
    }


    // String address = await AssistantMethods.searchCoordinateAddress(position,context);

  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
String home(){
  try{
if(Provider.of<AppData>(this.context).pickupLocation!=null){
return Provider.of<AppData>(this.context).pickupLocation.placeName;
}else{
  return "Add Home";
}
  }catch(exp){
    return "Home";
  }

}
  // DriverData dvr = new DriverData();
  // void pickUploadImage() async{
  //   final image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,);
  //   print(CurrentUseruid);
  //   await dvr.uploadImage( CurrentUseruid,image!.path, context);
  // }



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('MainScreen'),
        backgroundColor: Color(0xFFc6520a),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            //Drawer Header
            Container(
              // height: 185.0,
              child: Column(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                  child: Row(
                    children: [
                      GestureDetector(

                          child: Image.asset('images/user_icon.png',height: 65.0,width: 65.0,),
                      onTap: (){
                            // pickUploadImage();
                        print(CurrentUseruid);

    }

                      ),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${captainController.captain!.value.name}',style: TextStyle(fontSize: 16.0,fontFamily: 'Brand-Bold'),),
                        SizedBox(height: 6.0,),
                          Text('Visit Profile'),
                        ],
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
            DividerWidget(),
            SizedBox(
              height: 12.0,
            ),
            //Drawer Body Controller
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History',style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Visit Profile',style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About',style: TextStyle(fontSize: 15.0),),
            ),
            ListTile(
              onTap: (){
                Authentication().signOut();
              },
              leading: Icon(Icons.logout),
              title: Text('Logout',style: TextStyle(fontSize: 15.0),),
            ),

          ],
        ),
      ),

      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController=controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              locatePosition();
            },
          ),

          //HamburgerButton for drawer

          // Positioned(
          //   top: 45.0,
          //   left: 22.0,
          //   child: GestureDetector(
          //     onTap: (){
          //       scaffoldKey.currentState!.openDrawer();
          //     },
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(22.0),
          //         boxShadow: [BoxShadow(
          //           color: Colors.black,
          //           blurRadius: 6.0,
          //           spreadRadius: 0.5,
          //           offset: Offset(0.7,0.7),
          //         ),
          //         ]
          //       ),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.white,
          //         child: Icon(Icons.menu),
          //         radius: 20.0,
          //       ),
          //     ),
          //   ),
          // ),

          Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.0,
                      ),
                      Text("Hi There, ",style: TextStyle(fontSize: 12.0),),
                      Text("Where to? ",style: TextStyle(fontSize: 20.0,fontFamily: 'Brand-Bold'),),
                      SizedBox(height: 20.0,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.search,color: Colors.blueAccent,),
                                SizedBox(width: 10.0,),
                                Text('Search Drop off'),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 34.0,),
                      Row(
                        children: [
                          Icon(Icons.home,color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          GestureDetector(
                            onTap: (){
                              AssistantMethods.searchCoordinateAddress(currentPosition, context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(()=>Text(
                                  '${MainScreen.homeValue.value}',
                                ),),
                                SizedBox(height: 4.0,),
                                Text('Your living home address',style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10.0,),
                      DividerWidget(),

                      SizedBox(height: 16.0,),
                      Row(
                        children: [
                          Icon(Icons.work,color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Add Work'),
                              SizedBox(height: 4.0,),
                              Text('Your office address',style: TextStyle(color: Colors.black54,fontSize: 12.0),),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )),

        ],
      ),
    );
  }
}

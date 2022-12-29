import 'package:buraq_captain/Models/address.dart';
import 'package:flutter/cupertino.dart';



class AppData extends ChangeNotifier{

late Address pickupLocation;

void updatePickUpLocation(Address pickUpAddress){

pickupLocation = pickUpAddress;
notifyListeners();
}

}
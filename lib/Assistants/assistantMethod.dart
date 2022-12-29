import 'package:buraq_captain/AllScreens/mainscreen.dart';
import 'package:buraq_captain/Assistants/resquestAssistant.dart';
import 'package:buraq_captain/DataHandler/appData.dart';
import 'package:buraq_captain/Models/address.dart';
import 'package:buraq_captain/configMaps.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AssistantMethods {

static Future<String> searchCoordinateAddress(Position position,context) async{
  String placeAddress ='';
  String st1,st2,st3,st4;
  String url ="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

  var response = await RequestAssistant.getRequest(url);

  if(response!="failed"){
    placeAddress = response["results"][0]["formatted_address"];
    st1 = response['results'][0]['address_components'][1]['long_name'];
    st2 = response['results'][0]['address_components'][2]['long_name'];
    st3 = response['results'][0]['address_components'][3]['long_name'];
    st4 = response['results'][0]['address_components'][4]['long_name'];
    placeAddress = st1+", "+st2+", "+st3+", "+st4;
    print(placeAddress);

    MainScreen.homeValue.value = placeAddress;

    Address userPickupAddress = new Address(latitude: position.longitude,longititue: position.latitude,placeName: placeAddress);
    userPickupAddress.longititue = position.longitude;
    userPickupAddress.latitude = position.latitude;
    userPickupAddress.placeName=placeAddress;

    Provider.of<AppData>(context,listen: false).updatePickUpLocation(userPickupAddress);
  }

  return placeAddress;

  }
}
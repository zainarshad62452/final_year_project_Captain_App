import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
TextEditingController pickUpTextEditingController = TextEditingController();
TextEditingController dropOffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String home(){
  try{
if(Provider.of<AppData>(context).pickupLocation!=null){
return Provider.of<AppData>(context).pickupLocation.placeName;
}else{
  return "";
}
  }catch(exp){
    return "";
  }

}

    pickUpTextEditingController.text = home();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 215.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 25.0,top: 20.0,right: 25.0,bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back
                        ),
                    ),
                    Center(
                      child: Text('Set Drop Off',style: TextStyle(fontSize:18.0,fontFamily: "Brand-Bold"),
                    ),
                    ),
                  ],
                  ),
                  SizedBox(height: 16.0,),
      
      
                  Row(
                    children: [
                      Image.asset("images/pickicon.png",height: 16.0,width: 16.0,),
      
                      SizedBox(width: 18.0,),
      
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.0),
      
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickUpTextEditingController,
                              decoration: InputDecoration(
                                hintText: "PickUp Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0),
      
                              ),
                            ), 
                            ),
                        ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
      
                  
                  Row(
                    children: [
                      Image.asset("images/desticon.png",height: 16.0,width: 16.0,),
      
                      SizedBox(width: 18.0,),
      
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.0),
      
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0),
                              ),
                            ), 
                            ),
                        ),
                        ),
                    ],
                  ),
                ],
              ),
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}
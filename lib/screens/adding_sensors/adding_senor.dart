import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guard/constants.dart';
import 'package:flutter/services.dart';

class addSensors extends StatefulWidget {
  @override
  addSensors2 createState() => addSensors2();
}

class addSensors2 extends State<addSensors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:
      Container ( 
        color: kPrimaryColor2,
        child: 
        Column(children: [
          

        ],)
      
      )
    );
  }
}
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(0.5),
      elevation: 0,
      centerTitle: true,
      title: Text("Add Sensor"),
    );
  }

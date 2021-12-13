// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:guard/constants.dart';
import 'package:flutter/services.dart';
import 'package:guard/database.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  DetailsScreenx createState() => DetailsScreenx(name: name);
}

class DetailsScreenx extends State<DetailsScreen> {
  @override
  bool value = true;

  void initstate() {
    super.initState();
  }

  DetailsScreenx({
    Key? key,
    required this.name,
  });

  String name;
  onUpdate() {
    setState(() {
      value = !value; //toggles between true & false
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: buildAppBar(),
        body: StreamBuilder<Map<String, dynamic>>(
            stream: getReadings(widget.name),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final data = snapshot.data!;
              final temperature = data["Temperature"];
              final gas = data["Gas"];
              final humidity = data["Humidity"];
              final pressure = data["Pressure"];
              return SafeArea(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(children: [
                        SizedBox(height: size.height * 0.05),
                        Row(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/air_quality.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 35,
                                    child: FloatingActionButton.extended(
                                        onPressed: () {
                                          onUpdate();
                                          updateData(
                                              "BME680", 'Status ', value);
                                        },
                                        // extendedPadding: EdgeInsets.only(bottom: 10),
                                        label: value ? Text("On") : Text("Off"),
                                        backgroundColor: value
                                            ? kPrimaryColor2
                                            : Colors.grey,
                                        icon: Icon(
                                          value
                                              ? Icons.toggle_on
                                              : Icons.toggle_off,
                                        ))),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Air Quality',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  'Measures the air quality of your',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'room through temperature,',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'humidity, pressure and gas',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.05),
                        value == true
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$temperature',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'TEMPERATURE',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$pressure',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'PRESSURE',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                child: Text(
                                  'Sensor is turned off',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ),
                        SizedBox(height: 40),
                        value == true
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$humidity',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'HUMIDITY',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$gas',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'GAS',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row()
                      ])));
            }));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor2,
      elevation: 0,
      centerTitle: true,
      title: Text("LIVING ROOM"),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.edit),
        //   onPressed: () {},
        // ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {},
        ),
      ],
    );
  }
}

class InfoDetails extends StatelessWidget {
  const InfoDetails({
    Key? key,
    required this.reading,
    required this.value,
  }) : super(key: key);

  final String reading;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width / 4,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(this.reading),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(this.value.toString()),
          ),
        ],
      ),
    );
  }
}

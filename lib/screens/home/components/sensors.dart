// ignore_for_file: file_names
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guard/screens/details/details_screen1.dart';
import 'package:guard/database.dart';
import 'package:guard/screens/details/details_screen2.dart';

import '../../../constants.dart';

class sensors extends StatelessWidget {
  final String name1 = "BME688";
  final String name2 = "LTR-559";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          //for (int i = 0; i < 5; i++)

          //if()
          sensorsCards(
            image: "assets/images/air_quality.png",
            title: "Air Quality",
            name: name1,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    name: name1,
                  ),
                ),
              );
            },
          ),

          sensorsCards(
            image: "assets/images/light.png",
            title: "Light & Proximity",
            name: name2,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen2(name: name2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class sensorsCards extends StatelessWidget {
  const sensorsCards({
    Key? key,
    required this.image,
    required this.title,
    required this.name,
    required this.press,
  }) : super(key: key);

  final String image, title, name;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 4,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$name".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

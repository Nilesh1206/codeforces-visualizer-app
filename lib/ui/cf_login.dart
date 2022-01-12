// ignore_for_file: prefer_const_constructors

import 'package:cf_app/drawer.dart';
import 'package:cf_app/ui/user.dart';
import 'package:cf_app/ui/user1.dart';
// import 'package:cf_app/ui/SingleUserDetailsPage.dart';
import 'package:cf_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class SingleUserInputPage extends StatefulWidget {
  // const SingleUserInputPage({Key? key}) : super(key: key);
  @override
  _SingleUserInputPageState createState() => _SingleUserInputPageState();
}

class _SingleUserInputPageState extends State<SingleUserInputPage> {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _controller= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      // height:size.height,
      // width: size.width,
      child: Column(
        children: [
          Container(
            height: 50,
            width: size.width,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/cf-1.png')),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Welcome to Code_Loopers!',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
                // color: Colors.blue,
                border: Border.all(
                  color: Colors.blue.shade800,
                  width: 2,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7.0),
                  topLeft: Radius.circular(7.0),
                  bottomRight: Radius.circular(7.0),
                  bottomLeft: Radius.circular(7.0),
                )),
            child: Column(
              children: [
                Text(
                  'Login into Codeforces',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800]),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.blue.shade800,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Handle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  // padding: EdgeInsetsDirectional.all(7),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.shade800,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7.0),
                        topLeft: Radius.circular(7.0),
                        bottomRight: Radius.circular(7.0),
                        bottomLeft: Radius.circular(7.0),
                      )),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    controller: _controller,
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // fillColor: Colors.black,
                      hintText: 'Enter User Handle',
                      // errorText: 'Description cannot be empty'
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.grey,
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    // movetoDetailsPage(context);
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SingleUserDetailsPage(handle: _controller.text)),
            );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: ' "Think Twice ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                TextSpan(text: '\n'),
                TextSpan(
                    text: 'Write Once" ',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

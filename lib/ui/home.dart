// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cf_app/drawer.dart';
import 'package:cf_app/ui/ongoing_contest.dart';
import 'package:cf_app/ui/previous_contest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import 'package:http/http.dart' as http;




final snackBar=SnackBar(
  content: Text(
    'Notification Set for Contest!',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  backgroundColor: Colors.white,
);


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    String readTimestapmDif(int timestamp)
  {
    var now = new DateTime.now();
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);

    print("Time span : ${diff.inSeconds}");

    return diff.inSeconds.toString();
  }



  late int ContestId;



  _launchURL(int id) async{
      String url="https://codeforces.com/contest/" + id.toString();
      if( await canLaunch(url)){
        await launch(url);
      }
      else
      {
        throw 'Could not launch $url';
      }
  }

    // lOCAL pUSH NOTIFICATION

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidInitializationSettings androidInitializationSettings;
  late IOSInitializationSettings iosInitializationSettings;
  late InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    // initializing();
  }


  Event contestEvent (int durationInSeconds,DateTime dateTime,String title){
      return Event(
        title: title,
        description: 'Coding contest',
        location: 'Codeforces',
        endDate: dateTime.add(Duration(minutes: durationInSeconds)),
        startDate: dateTime,
      );
    }

  void _showNotifications() async {
    await notification();
  }

  void _showNotificationsAfterSecond(int time) async {
    print("Time : $time");
    await notificationAfterSec(time.abs());
  }


  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hello there', 'You have Upcoming Contests', notificationDetails);
  }

  Future<void> notificationAfterSec(int time) async {
    var timeDelayed = DateTime.now().add(Duration(seconds: time));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'Hello Coder!',
        'Its Contest Time', timeDelayed, notificationDetails);
  }

  Future onSelectNotification(String payLoad) async {
    if (payLoad != null) {
      print("payLoad : $payLoad");
    }



    _launchURL(this.ContestId);

  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _handle1Controller = TextEditingController();
  TextEditingController _handle2Controller = TextEditingController();
  int bal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'UPCOMING CONTEST',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Image(
            image: AssetImage("assets/images/cf.png"),
          ),
        ],
      ),
      drawer: MyDrawer(),
      // ignore: unnecessary_new
      body: new FutureBuilder(
          future: contestInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // throw "Could Not launch this ";
              
              return ListView.builder(
                  itemCount: snapshot.data['result'].length,
                  itemBuilder:  (context, index) {
                    if (snapshot.data['result'][index]['phase'] == "BEFORE") {
                      bal = index;
                      print("check: $bal");
                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: Offset(2, 1),
                            ),
                          ],
                        ),
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        color: Colors.black, 
                                        fontSize: 12.0),
                                        softWrap: true,
                                  ),
                                  Text(
                                    "Type",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                    softWrap: true,
                                  ),
                                  Text(
                                    "Duration",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                    softWrap: true,
                                  ),
                                  Text(
                                    "Start",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                    softWrap: true,
                                  ),

                                ],
                              ),
                              VerticalDivider(),
                              Column(
                                children: <Widget>[
                                  Text(":"),
                                  // SizedBox(height: ,),
                                  Text(":"),
                                  Text(":"),
                                  Text(":"),
                                ],
                              ),
                              VerticalDivider(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data['result'][index]['name'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.0,
                                    ),
                                    softWrap: true,
                                    ),
                                    Text(
                                    snapshot.data['result'][index]['type'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.0,
                                    ),
                                  ),

                                  Text(
                                    // duration(snapshot.data['result'][index]
                                    //     ['durationSeconds']),
                                    ((snapshot.data['result'][index]
                                                    ['durationSeconds']) /
                                                (60 * 60))
                                            .toString() +
                                        " hr",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Text(
                                    startTime(snapshot.data['result'][index]
                                        ['startTimeSeconds']),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  ],
                                ),
                              ),
                              // VerticalDivider(),
                              IconButton(
                                iconSize: 30,
                                color: Colors.blue,
                                onPressed: (){
                                  int duration= (snapshot.data['result'][index]['durationSeconds']);
                                  // var minutes=0;
                                  // var hours=int.parse(duration[0]);
                                  // hours*=60;
                                  // var len=duration.length;
                                  // for(var i=2;i<len;i++)
                                  // {
                                  //   var min1=int.parse(duration[i]);
                                  //   minutes+=min1;
                                  // }
                                  // minutes+=hours;
                                  
                                  int min1=60;
                                  int minutesT=duration~/min1;
                                  print("Minutes: ${minutesT}");
                                  // DateTime dateTime=startTime(snapshot.data['result'][index]['startTimeSeconds']) as DateTime;
                                  String title1=snapshot.data['result'][index]['name'];
                                  print(title1);
                                  DateTime start=(snapshot.data['result'][index]['startTimeSeconds']);
                                  print(start);
                                  var date = DateTime.fromMillisecondsSinceEpoch(snapshot.data['result'][index]['startTimeSeconds'] * 1000);
                                  Add2Calendar.addEvent2Cal(contestEvent(minutesT,start, title1));
                                  


                              }, icon: Icon(Icons.date_range))
                            ],
                          ),
                          onTap: (){
                            // _showNotificationsAfterSecond(int.parse(
                            //   readTimestapmDif(snapshot.data['result'][index]
                            //   ['startTimeSeconds'])
                            // ));
                            _launchURL(snapshot.data['result'][index]['id']);
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                        ),
                      );
                    }
                    else
                    {
                      return Container();
                    }
                  });

                  
            };
            
          }),
          bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
              color: Colors.red,
            ),
            title: Text(
              "UPCOMING",
              style: TextStyle(color: Colors.black,fontSize: 12),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update,color: Colors.blue,),
            title: Text("PREVIOUS",style: TextStyle(color: Colors.black,)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer,color: Colors.green,),
            title: Text("ONGOING",style: TextStyle(color: Colors.black,)),
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (value == 1) {
            // print("h, bal $bal");
            bal++;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PreviousContests(this.bal)),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ongoing()),
            );
          }
          ;
        },
      ),
    );
  }
}


Future<Map<String, dynamic>> contestInfo() async {
  String url = "https://codeforces.com/api/contest.list";
  http.Response data = await http.get(Uri.parse(url));
  return json.decode(data.body);
}

String startTime(timestamp) {
  var format = new DateFormat('EEE dMMMM y HH:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var time = format.format(date);
  return time;
}

String duration(timestamp) {
  double h, min = 0;
  if (timestamp % 3600 == 0)
    h = (timestamp / 3600);
  else {
    h = timestamp % 3600;
    timestamp = timestamp - (timestamp * h);
    min = timestamp;
  }

  return h.toString() + 'hr ' + min.toString() + 'min';
}
// import 'package:cf_appapp/utilities/constants.dart';
import 'package:cf_app/ui/home.dart';
import 'package:cf_app/ui/ongoing_contest.dart';
import 'package:cf_app/ui/previous_contest.dart';
import 'package:cf_app/ui/cf_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.blue,
      child: Container(
        // color: kPrimaryColor,
        // color: Colors.blue,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                accountName: Text(
                  "Codeforces",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: GoogleFonts.mateSc().fontFamily),
                ),
                accountEmail: Text(
                  "Visualizer",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: GoogleFonts.mateSc().fontFamily),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/codeforces.png"),
                ),
              ),
            ),
            ListTile(
              onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
              },
              leading: const Icon(
                CupertinoIcons.home,
                color: Colors.black,
              ),
              title: const Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SingleUserInputPage()),
            );
              },
              leading: const Icon(
                CupertinoIcons.profile_circled,
                color: Colors.black,
              ),
              title: const Text(
                "Search User",
                textScaleFactor: 1.2,
                style: const TextStyle(color: Colors.black),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

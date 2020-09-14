import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String phone = "";
  bool loggingIn = false;
  TextEditingController phoneController = TextEditingController();

  login() {
    setState(() {
      loggingIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(("Home"), style: TextStyle(fontSize: 12)),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  "lib/app/assets/committee.png",
                ),
                size: 30,
              ),
              title: Text(("Committees"), style: TextStyle(fontSize: 12)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              title: Text(("Pay Now"), style: TextStyle(fontSize: 12)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text(("Transactions"), style: TextStyle(fontSize: 12)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(("Settings"), style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  color:  Theme.of(context).primaryColor,
                  height: _height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          backgroundImage:
                              AssetImage("lib/app/assets/Avatar.png"),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Juhi Jaferri",
                              style: TextStyle(color: Colors.white)))
                    ],
                  )),
              Container(
                  child: Column(
                children: [
                  Image.asset(
                    "lib/app/assets/savings-gold.png",
                    height: 50,
                  ),
                  Container(
                      child: Text("Your patience and discipline is paying off!",
                          style: TextStyle(
                              fontSize: 12, color:  Theme.of(context).primaryColor))),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text("Lifetime savings",
                          style: TextStyle(
                              fontSize: 20, color:  Theme.of(context).primaryColor))),
                  Container(
                      child: Text("PKR 415,000",
                          style: TextStyle(
                              fontSize: 30, color:  Theme.of(context).primaryColor)))
                ],
              ))
            ],
          ),
        ));
  }
}

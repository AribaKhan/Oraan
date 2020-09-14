import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraan/app/utils/networkUtils.dart';

class HomePage extends StatefulWidget {
  final dynamic id;
  @override
  HomePageState createState() => HomePageState(this.id);
  HomePage({
    Key key,
    @required this.id,
  }) : super(key: key);
}

class HomePageState extends State<HomePage> {
  String phone = "";
  bool loggingIn = false;
  bool isLoading = false;
  String savings = "";
  TextEditingController phoneController = TextEditingController();
  HomePageState(id);
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    lifetimesaving();
    super.initState();
  }

  lifetimesaving() async {
    setState(() {
      loggingIn = true;
    });
    var responseJson = await NetworkUtils.lifetimeSaving(widget.id);
    var message = "";

    print(responseJson);

    if (responseJson["data"]["lifeTimeSavings"] != null) {
      savings = responseJson["data"]["lifeTimeSavings"];
      setState(() {
        isLoading = false;
      });
    } else {
      savings = "Not found";
      Fluttertoast.showToast(
          msg: "Unexpected error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 4);
    }
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
                  color: Theme.of(context).primaryColor,
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
                              fontSize: 12,
                              color: Theme.of(context).primaryColor))),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text("Lifetime savings",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor))),
                  isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          child: Text("PKR " + savings,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context).primaryColor)))
                ],
              ))
            ],
          ),
        ));
  }
}

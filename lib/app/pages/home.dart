import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraan/app/components/committees_card.dart';
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
  int _value = 1;
  String savings = "";
  TextEditingController phoneController = TextEditingController();
  List<Map<dynamic, dynamic>> committeesDataList = [
    {
      "startingDate": "JULY 2020",
      "endingDate": "November 2020",
      "members": "5 ",
      "title": "Oraan Changing Savers",
      "payouts": [
        {
          "payoutMonth": "November Payout",
          "payoutAmount": "PKR 100,000",
        },
      ],
      "installmentType": "Monthly Installment",
      "installmentAmount": "PKR 20,000",
    },
    {
      "startingDate": "October 2019",
      "endingDate": "July 2020",
      "members": "50 ",
      "title": "Oraan Changing Savers",
      "payouts": [
        {
          "payoutMonth": "October Payout",
          "payoutAmount": "PKR 200,000",
        },
        {
          "payoutMonth": "July Payout",
          "payoutAmount": "PKR 200,000",
        },
      ],
      "installmentType": "Monthly Installment",
      "installmentAmount": "PKR 40,100",
    },
  ];
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                height: _height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("Your Committees",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 20))),
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: Text("YOUR PAYOUTS & INSTALLMENTS",
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600)))
                  ],
                )),
            Container(
            
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("All committees",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor)),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal:15.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: Icon(Icons.menu,
                                  color: Theme.of(context).primaryColor),
                              // value: _value,
                              items: [
                                DropdownMenuItem(
                                  child: Text("All committees"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Active committees"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                    child: Text("Ended committees"), value: 3),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                        ))
                  ]),
            ),
            Container(
                height: _height,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: committeesDataList != null &&
                            committeesDataList.length > 0
                        ? committeesDataList.length
                        : 0,
                    itemBuilder: (context, index) {
                      return Committees(json: committeesDataList[index]);
                    }))
          ],
        )));
  }
}

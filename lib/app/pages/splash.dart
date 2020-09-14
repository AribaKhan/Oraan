import 'package:flutter/material.dart';
import 'package:oraan/app/pages/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Container(
            alignment: Alignment.center,
            height: _height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/app/assets/oraanlogo_app_portraitversion_white.png",
                  scale: 2,
                ),
                Container(
                    width: _width / 1.5,
                    child: Text(
                      'Save money and money will save you',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 15),
                    )),
              ],
            )));
  }
}

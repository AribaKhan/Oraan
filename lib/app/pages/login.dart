import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oraan/app/pages/home.dart';
import 'package:oraan/app/utils/networkUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String phone = "";
  String passcode = "";
  bool loggingIn = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passcodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  login() async {
    setState(() {
      loggingIn = true;
    });
    var responseJson = await NetworkUtils().loginAccount(
      phone,
      passcode,
    );
    var message = "";
    var id;
    print(responseJson);

      message = responseJson["data"]["message"];
    id = responseJson["data"]["userId"];
    if (message == "user not found") {
      Fluttertoast.showToast(
          msg: "User not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 4);
      setState(() {
        loggingIn = false;
      });
    } else if (id != null && message == "user login success") {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        PageRouteBuilder(
            transitionsBuilder: (context, anim1, anim2, child) =>
                Container(child: child),
            transitionDuration: Duration(seconds: 0),
            pageBuilder: (context, anim1, anim2) => HomePage(id: id)),
      );
      setState(() {
        loggingIn = false;
      });
    } else {
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
        body: Form(
      key: formKey,
      child: Container(
          alignment: Alignment.center,
          height: _height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: _width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 30,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                                size: 18,
                              ))),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25),
                          child: Text("Welcome back.",
                              style: TextStyle(fontSize: 28)))
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: TextFormField(
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: new InputDecoration(
                    labelText: ("Phone number"),
                    labelStyle: TextStyle(color: Colors.grey),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    hintText: ("Phone number"),
                  ),
                  validator: (val) =>
                      val.length == 0 ? 'Phone cannot be empty.' : null,
                  onSaved: (val) => phoneController.text = val,
                  controller: new TextEditingController.fromValue(
                      new TextEditingValue(
                          text: phoneController.text,
                          selection: new TextSelection.collapsed(
                              offset: phoneController.text.length))),
                  onChanged: (val) {
                    phoneController.text = val;
                    phone = val;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: TextFormField(
               obscureText: true,
                  decoration: new InputDecoration(
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    labelText: ("Passcode"),
                    labelStyle: TextStyle(color: Colors.grey),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    hintText: ("Passcode"),
                  ),
                  validator: (valp) =>
                      valp.length == 0 ? 'Passcode cannot be empty.' : null,
                  onSaved: (valp) => passcodeController.text = valp,
                  controller: new TextEditingController.fromValue(
                      new TextEditingValue(
                          text: passcodeController.text,
                          selection: new TextSelection.collapsed(
                              offset: passcodeController.text.length))),
                  onChanged: (valp) {
                    passcodeController.text = valp;
                    passcode = valp;
                  },
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: new FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      color: Theme.of(context).accentColor,
                      child: loggingIn
                          ? Container(
                              padding: EdgeInsets.all(5),
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: new Theme(
                                    data: Theme.of(context)
                                        .copyWith(accentColor: Colors.white),
                                    child: new CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )))
                          : Text(
                              '  LOGIN  ',
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          login();
                        }
                      })),
              FlatButton(
                  onPressed: null,
                  child: FlatButton(
                      onPressed: () {},
                      child: Text("FORGOT PASSCODE?",
                          style: TextStyle(
                              color: loggingIn
                                  ? Colors.grey
                                  : Theme.of(context).accentColor,
                              fontSize: 16))))
            ],
          )),
    ));
  }
}

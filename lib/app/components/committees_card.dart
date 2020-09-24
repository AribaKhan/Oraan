import 'package:flutter/material.dart';

class Committees extends StatelessWidget {
  final json;

  Committees({this.json});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return this.json == null
        ? CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: _width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              elevation: 5,
              child: Container(
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                            this.json["startingDate"] +
                                "-" +
                                this.json["endingDate"] +
                                " . " +
                                this.json["members"] +
                                "MEMBERS",
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor)),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                  child: Text(this.json["title"],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios, size: 14)
                            ],
                          )),

                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: this.json["payouts"].length,
                          itemBuilder: (_, int i) => Row(
                                children: [
                                  i == 0
                                      ? Container(
                                          width: 30,
                                          child: Image.asset(
                                              "lib/app/assets/payouts-24px.png"),
                                        )
                                      : Container(
                                          width: 30,
                                        ),
                                  Text(
                                    this.json["payouts"][i]["payoutMonth"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(this.json["payouts"][i]["payoutAmount"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).accentColor))
                                ],
                              )),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                child: Image.asset(
                                    "lib/app/assets/instalments-24px.png"),
                              ),
                              Text(this.json["installmentType"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              Spacer(),
                              Text(this.json["installmentAmount"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).primaryColorDark))
                            ],
                          ))

                      // leading:
                      //  ListView.builder(
                      // physics: ScrollPhysics(),
                      // shrinkWrap: true,
                      // itemCount: this.json["payouts"].length,
                      // itemBuilder: (_, int i) =>
                      //  Text(this.json["payouts"][i]["payoutAmount"])
                      // )
                    ],
                  ),

//                   ListTile(
// trailing:

//                   Image.asset("lib/app/assets/committee.png"),
//                 title:   ListView.builder(
//                                               physics: ScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount: this.json["payouts"].length,
//                                               itemBuilder: (_, int i) =>
//                                               Text(this.json["payoutMonth"])
//                                               ),
//                                               leading:
//                                                ListView.builder(
//                                               physics: ScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount: this.json["payouts"].length,
//                                               itemBuilder: (_, int i) =>
//                                                Text(this.json["payoutAmount"])
//                                               )
//                   ),

//                      ],),
                ),
              ),
            ));
  }
}

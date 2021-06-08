import 'dart:core';
import 'dart:ffi';



import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter naviagtion',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.green,
      ),
      home: DashboardLandingScreen(),
    );
  }
}

class DashboardLandingScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
    builder: (context) => DashboardLandingScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Dashboard landing screen.'),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('create'),
              onPressed: () => Navigator.of(context).push(
                ActivityScreen.route(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(
    builder: (context) => ActivityScreen(),
  );
  TextEditingController activename = TextEditingController();
  TextEditingController activetype = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NestedScrollView(

        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Create an activity'),
          ),
          ];
         },
           body: SingleChildScrollView(
              child: Column(
              children: <Widget>[
               Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextField(
                controller: activename ,
                decoration: InputDecoration
                  (
                    labelText: "Activity name",
                    labelStyle:TextStyle(color: Colors.black,
                        fontStyle: FontStyle.normal,fontSize: 25),
                    hintText: "Ex: Cooking Class",
                    errorText: ( 'Name should be max 120 character'),
               ),
                maxLength: 120,
              ),
               ),
               Padding(
                padding: EdgeInsets.only(top: 50.0,bottom:200),
                 child: new TextField(
                controller: activetype,
                decoration: InputDecoration
              (
                labelText: "Activity type",
                labelStyle:TextStyle(color: Colors.black,
                    fontStyle: FontStyle.normal,fontSize: 25),
                hintText: "Ex: Cooking Class",
                 ),
                  ),
              ),


             new Align(
              alignment: Alignment.bottomRight,
              // ignore: deprecated_member_use
               child: RaisedButton(

                child: Text(' NEXT'),
                 color: Colors.black,
                 textColor: Colors.white,
                onPressed: () =>
                  Navigator.of(context).push(
                  NewTopic.route(),
                ),
                ),
           )
            ],
                ),
              ),
      )
      )
    );
    }
}
 /*String? _validate(String userInput) {
  if (!(userInput.length > 120) && userInput.isNotEmpty) {
    return "correction required in activity name ";
  }
  return null;

}
*/
class NewTopic extends StatelessWidget {


  static Route route() =>
      MaterialPageRoute(
        builder: (context) => NewTopic(),
      );
  @override


  TextEditingController Startdate = TextEditingController();
  TextEditingController Enddate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text('date of activity'),
                ),
              ];
            },

            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: new TextField(
                      controller: Startdate,
                      decoration: InputDecoration
                        (
                        labelText: "Start date",
                        labelStyle: TextStyle(color: Colors.black,
                            fontStyle: FontStyle.normal, fontSize: 25),
                        hintText: 'Dec 02,2020',
                      ),
                     onTap:() async {
                       DateTime? PickedDate = await showDatePicker(
                           context: context,
                           initialDate: DateTime.now(),
                           firstDate: DateTime(2000),
                           //DateTime.now() - not to allow to choose before today.
                           lastDate: DateTime(2101)
                       );
                       if(PickedDate != null ) {
                         print(PickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                         String formattedDate = DateFormat('yyyy-MM-dd').format(PickedDate) ;


                        // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                         //you can implement different kind of Date Format here according to your requirement
                         Startdate.text = formattedDate;
                         //PickedDate=info ;
                           (context as Element).markNeedsBuild();//set output date to TextField value.
                       }else{
                         print("Date is not selected");
                       }
                       },
                    ),
                  ),
                    Padding(
                    padding: EdgeInsets.only(top: 50.0, bottom: 200),
                    child: new TextField(
                      controller: Enddate,
                      decoration: InputDecoration
                        (
                        labelText: "End date",
                        labelStyle: TextStyle(color: Colors.black,
                            fontStyle: FontStyle.normal, fontSize: 25),
                        hintText: "Dec 02,2020",
                        errorText: ('Start date should be greater than End date'),
                      ),
                      onTap:() async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:  DateTime(2000),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101)
                        );
                        if(pickedDate != null){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate) ;
                           // 2020-01-02 03:04:05.000

                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement


                          Enddate.text = formattedDate;
                          // (Info > info);
                           (context as Element).markNeedsBuild();//set output date to TextField value.

                        }else{
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),


                  new Align(
                    alignment: Alignment.bottomRight,
                    // ignore: deprecated_member_use
                    child: RaisedButton(

                        child: Text('Ok'),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () =>
                            Navigator.of(context).push(
                              CreatedTopicDetails.route(),)
                    ),

                  ),

                ],
              ),
            ),
          )),
    );
  }

  getdata(info) {}
}



class CreatedTopicDetails extends StatelessWidget {
  static Route route() => MaterialPageRoute(
    builder: (context) => CreatedTopicDetails(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text('page:new activity page'),
      ),
    );
  }
}
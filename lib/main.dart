import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime dateTime;

  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Alert"),
        content: new Text(DateFormat.yMMMd().add_jm().format(dateTime)),
        actions: <Widget>[
          // new CupertinoDialogAction(
          //     child: const Text('Discard'),
          //     isDestructiveAction: true,
          //     onPressed: () {
          //       Navigator.of(context, rootNavigator: true).pop("Discard");
          //     }),
          new CupertinoDialogAction(
              child: const Text('OK'),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context, 'OK');
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: new CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text("iOS Demo")),
          child: SafeArea(
              child: Center(
                  child: RaisedButton(
            onPressed: () {
              _awaitDate(context);
            },
            child: Text('Open Datepicker'),
          ))),
        ));
  }

  void _awaitDate(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectionScreen(),
        ));

    if (result != null) {
      setState(() {
        dateTime = result;
        displayDialog();
      });
    }
  }
}

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: new CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            trailing: CupertinoButton(
              child: const Text('Done'),
              padding: EdgeInsets.zero,
              onPressed: () {
                _sendDateBack(context);
              },
            ),
          ),
          child: SafeArea(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Icon(
                        CupertinoIcons.clock,
                        color: CupertinoColors.lightBackgroundGray,
                        size: 28,
                      ),
                      SizedBox(width: 6),
                      Text('Time')
                    ],
                  ),
                  Text(DateFormat.yMMMd().add_jm().format(dateTime))
                ],
              ),
              Container(
                height: 216,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (newDateTime) {
                    setState(() {
                      dateTime = newDateTime;
                    });
                  },
                ),
              ),
            ],
          )),
        ));
  }

  void _sendDateBack(BuildContext context) {
    Navigator.pop(context, dateTime);
  }
}

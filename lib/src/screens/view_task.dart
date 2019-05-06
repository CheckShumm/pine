import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/utils/CustomShapeClipper.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class ViewTask extends StatefulWidget {
  Task task;
  ViewTask({this.task});

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.green);

    return new Scaffold(
        backgroundColor: Colors.green[75],
        appBar: new AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.edit),
            ),
          ],
          elevation: 0,
          title: null,
        ),
        body: Container(
          color:Colors.green[75],
          child: Column(
            children: <Widget>[
              ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      color: theme.primaryColor,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 32.0),
                            child: Text(widget.task.title,
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ],
                      ))),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: 
                    Text(widget.task.description,
                        style: TextStyle(
                            fontSize: 18.0, color: theme.primaryColor)),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/utils/CustomShapeClipper.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pine/src/widgets/color_dropdown.dart';

class ViewTask extends StatefulWidget {
  Task task;
  ViewTask({this.task});

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return new 
       StreamBuilder<List<Task>>(
          stream: bloc.getSubject().stream,
          builder: (context, snapshot) => _viewTask(snapshot.data[widget.task.index]));
        
  }

  // Returns a the body of the task view
  _viewTask(Task task) {
    print("task ID: " + task.id.toString());
    print("task index: " + task.index.toString());

    FlutterStatusbarcolor.setStatusBarColor(task.color);
    Color backgroundColor = bloc.getTasks()[task.index].color[100];
    //Color backgroundColor = task.color.withOpacity(100.0);
    //Color backgroundColor = Colors.red[100];
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: new AppBar(
          backgroundColor: task.color,
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
                color: backgroundColor,
                child: Column(
                  children: <Widget>[
                    ClipPath(
                        clipper: CustomShapeClipper(),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            color: task.color,
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
                      child: Column(
                        children: <Widget>[
                          Text(widget.task.description,
                              style: TextStyle(
                                  fontSize: 18.0, color: task.color)),
                          ColorDropDown(
                              task: task),
                        ],
                      ),
                    ),
                  ],
                ),
              ));}
  
}

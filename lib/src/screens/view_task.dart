import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/screens/create_task.dart';
import 'package:pine/src/utils/CustomShapeClipper.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pine/src/widgets/color_dropdown.dart';
import 'package:pine/src/widgets/icon_dropdown.dart';

class ViewTask extends StatefulWidget {
  final Task task;
  ViewTask({this.task}) {
    taskBloc.viewTask(this.task);
  }

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<Task>(
        stream: taskBloc.getTaskSubject().stream,
        builder: (context, snapshot) => _viewTask(snapshot.data));
  }

  // Returns a the body of the task view
  _viewTask(Task task) {
    ColorSwatch colorSwatch = task.color;
    Color backgroundColor = colorSwatch[50];
    Color taskColor = colorSwatch[400];
    FlutterStatusbarcolor.setStatusBarColor(taskColor);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: new AppBar(
          backgroundColor: taskColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                tooltip: "delete",
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 3000));
                  print("DELETE");
                  taskBloc.deleteTask(task);
                },
              ),
            ),
          ],
          elevation: 0,
          title: null,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: FractionalOffset.topCenter,
                    child: Container(
                        color: taskColor,
                        width: screenSize.width,
                        height: screenSize.height * 0.20,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(task.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26.0)),
                            ),
                            Text(widget.task.description,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                          ],
                        )),
                  ),
                  Container(
                    //height: MediaQuery.of(context).size.height * 0.10,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: IconDropdown(task: task)),
                        Container(
                          height: 32.0,
                          decoration: BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 2.0, color: task.color))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ColorDropDown(task: task),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 300,
                      width: screenSize.width,
                      child: subtasks(task))
                ],
              ),
            ),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: CreateTask(
                  task: task,
                  isSubtask: true,
                  labelIcon: Icon(Icons.playlist_add_check),
                  labeltext: "Add a Subtask",
                ))
          ],
        ));
  }

  Widget subtasks(Task task) {
    if (task.subtasks.isEmpty) {
      return Center(
          child: new Text("Add subtasks to help define your task",
              style: TextStyle(color: task.color, fontSize: 18.0)));
    } else {
      return new ListView(children: task.subtasks.map(_buildSubtask).toList());
    }
  }

  Widget _buildSubtask(String subtask) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
        child: Card(
            elevation: 8.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(subtask,
                      style: TextStyle(fontSize: 16, color: widget.task.color)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.check_circle_outline),
                )
              ],
            )),
      ),
    );
  }
}

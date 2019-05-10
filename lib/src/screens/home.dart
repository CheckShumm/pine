import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/screens/create_task.dart';
import 'package:pine/src/screens/create_task.dialog.dart';
import 'package:pine/src/screens/view_task.dart';
import 'package:pine/src/widgets/ReorderableListSimple.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    taskBloc.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text(widget.title, style: TextStyle(fontSize: 20.0)),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.help),
          ),
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(),
      body: Stack(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Center(
                  child: StreamBuilder<List<Task>>(
                      stream: taskBloc.getSubject().stream,
                      builder: (context, snapshot) => taskList(snapshot.data)),
                ),
              )),
          Align(alignment: FractionalOffset.bottomCenter, child: CreateTask(isSubtask: false, labelIcon: Icon(Icons.playlist_add), labeltext: "Create a Task",))
        ],
      ),
    );

    // floatingActionButton: FloatingActionButton(
    //   elevation: 10,
    //   backgroundColor: Colors.white,
    //   foregroundColor: Colors.green[300],
    //   onPressed: () {
    //     _createTaskDialog();
    //   }, // task taskBloc update events
    //   tooltip: 'Increment',
    //   child: Icon(Icons.add),
    // ),
  }

  onCreate(taskController) {
    if (taskController.text.isNotEmpty) {
      taskBloc.createTask(taskController.text, "description", "type");
    }
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _reorderCallBack(int oldIndex, int newIndex) {}

  Widget taskList(List<Task> data) {
    if (taskBloc.getTasks().isEmpty) {
      return Text('Get ready for tomorrow, \nAdd some tasks!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0));
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ReorderableListSimple(
          children: data.map(_buildItem).toList(),
          onReorder: this._reorderCallBack,
        ),
      );
    }
  }

  Future<void> _createTaskDialog() async {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CreateTaskDialog();
        });
  }

  Widget _buildItem(Task task) {
    final ThemeData theme = Theme.of(context);
    // Map<Key, Task> tasks = bloc.getTasks();
    // Task task = tasks[key];
    print(task.title);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return new ViewTask(task: task);
                  },
                  fullscreenDialog: true))
              .then((val) =>
                  {FlutterStatusbarcolor.setStatusBarColor(Colors.green[300])});
        },
        child: Container(
          decoration: BoxDecoration(
              border: new Border(
                  left: new BorderSide(width: 1.0, color: task.color))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(task.iconData, color: task.color),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(task.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: task.color,
                            fontSize: 18.0,
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

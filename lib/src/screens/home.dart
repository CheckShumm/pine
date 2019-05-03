import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/screens/create_task.dart';
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
    bloc.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<List<Task>>(
            stream: bloc.getSubject().stream,
            builder: (context, snapshot) => ReorderableListSimple(
                  children: snapshot.data.map(_buildItem).toList(),
                  onReorder: this._reorderCallBack,
                )),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () {
          _openAddTaskDialog();
        }, // task bloc update events
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _reorderCallBack(int oldIndex, int newIndex) {}

  void _openAddTaskDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new CreateTaskDialog();
        },
        fullscreenDialog: true));
  }

  Widget _buildItem(Task task) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: new Border(
                left: new BorderSide(width: 1.0, color: theme.primaryColor))),
        child: Column(
          key: new ValueKey(task.id),
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(task.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)))),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(32.0,4.0,0,0),
                    child: Text(task.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic)))),
          ],
        ),
      ),
    );
  }
}

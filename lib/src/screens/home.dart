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
    log('Task Title: $task.title');
    return new Card(
      key: new ValueKey(task.id),
      color: Colors.green[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: new Text(task.title),
            subtitle: new Text(task.description),
          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('View'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('Edit'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

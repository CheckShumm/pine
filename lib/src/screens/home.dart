import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/screens/create_task.dart';


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
            builder: (context, snapshot) => ListView(
                  children: snapshot.data.map(_buildItem).toList(),
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

  void _openAddTaskDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return new CreateTaskDialog();
      },
      fullscreenDialog: true
    ));
  }

  Widget _buildItem(Task task) {
    log('Task Title: $task.title');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Card(
        color: Colors.green[50],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
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
      ),
    );
  }
}

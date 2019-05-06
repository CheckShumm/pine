import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pine/src/data/database_helper.dart';
import 'package:pine/src/data/task.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc {
  var _tasks = new List<Task>();
  final _taskSubject = BehaviorSubject<List<Task>>();

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  TaskBloc() {
    this._query();
  }

  getSubject() {
    return _taskSubject;
  }

  getTasks() {
    // _taskSubject.sink.add(_tasks);
    return _tasks;
  }

  updateTasks(title, description, type) {
    Task newTask = new Task(id: _tasks.length, title: title, description: description, type: type);
    this._tasks.add(newTask);
    _taskSubject.sink.add(this._tasks);
    _insert(newTask);
    //this.dispose();
  }

  setTaskColor(int id, Color color) {
    _tasks[id].setColor(color);
  }

  swap(int draggedItem, int newPosition) {
    Task swappedTask = _tasks[draggedItem];
    this._tasks[draggedItem] = this._tasks[newPosition];
    this._tasks[newPosition] = swappedTask;
    //_taskSubject.sink.add(this._tasks);
    //this.dispose();
  }

  void _insert(Task task) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle : task.title,
      DatabaseHelper.columnDescription  : task.description
    };
    final id = await databaseHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await databaseHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  dispose() {
    _taskSubject.close();
  }
}

final bloc = TaskBloc();

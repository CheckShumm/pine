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

  createTask(title, description, type) {
    Task newTask = new Task(
        id: _tasks.length,
        index: _tasks.length,
        title: title,
        description: description,
        type: type,
        subtasks: new List<String>(),
        color: Colors.green,
        iconData: Icons.assignment);
    this._tasks.add(newTask);
    _taskSubject.sink.add(this._tasks);
    _insert(newTask);
    //this.dispose();
  }

  addSubTask(task, index) {
    this._tasks[index].subtasks.add(task);
    _taskSubject.sink.add(this._tasks);
  }



  setTaskColor(int index, Color color) {
    this._tasks[index].setColor(color);
    _taskSubject.sink.add(this._tasks);
  }

  setTaskIcon(int index, IconData iconData) {
    this._tasks[index].setIconData(iconData);
    _taskSubject.sink.add(this._tasks);
  }

  swap(int draggedItem, int newPosition) {
    Task swappedTask = _tasks[draggedItem];

    // swap task object
    this._tasks[draggedItem] = this._tasks[newPosition];
    this._tasks[newPosition] = swappedTask;

    // swap task index
    this._tasks[draggedItem].setIndex(draggedItem);
    this._tasks[newPosition].setIndex(newPosition);
  }

  void _insert(Task task) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle: task.title,
      DatabaseHelper.columnDescription: task.description
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

final taskBloc = TaskBloc();

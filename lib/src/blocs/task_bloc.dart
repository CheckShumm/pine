import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pine/src/data/database_helper.dart';
import 'package:pine/src/data/task.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc {
  var _tasks = new List<Task>();
  final _taskListSubject = BehaviorSubject<List<Task>>();
  final _taskSubject = BehaviorSubject<Task>();

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  TaskBloc() {
    this._init();
  }

  _init() async {
    final allRows = await databaseHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) =>
        this.createTask(row['title'], row['description'], "type", row["_id"]));
  }

  viewTask(Task task) {
    _taskSubject.sink.add(task);
  }

  getTaskSubject() {
    return _taskSubject;
  }

  getSubject() {
    return _taskListSubject;
  }

  getTasks() {
    // _taskListSubject.sink.add(_tasks);
    return _tasks;
  }

  createTask(title, description, type, id) async {
    Task newTask = new Task(
        index: _tasks.length ,
        title: title,
        description: description,
        type: type,
        subtasks: new List<String>(),
        color: Colors.green,
        iconData: Icons.assignment);

    if(id == -1) {
      _insert(newTask);
      final taskID = await databaseHelper.queryRowCount();
      newTask.setID(taskID);
    } else {
      newTask.setID(id);
    }
    this._tasks.add(newTask);
    _taskListSubject.sink.add(this._tasks);

    //this.dispose();
  }

  deleteTask(task) {
    
    for (int i = 0; i<this._tasks.length; i++) {
      if(this._tasks[i] == task) {
        print("WE ARE DELETING THIs");
        this._delete(task);
        this._tasks.removeAt(i);
      } 
    }

    _taskListSubject.sink.add(this._tasks);
  }

  addSubTask(subtask, task) {
    task.subtasks.add(subtask);
    _taskListSubject.sink.add(this._tasks);
  }

  setTaskColor(Task task, Color color) {
    task.setColor(color);
    _taskSubject.sink.add(task);
  }

  setTaskIcon(Task task, IconData iconData) {
    task.setIconData(iconData);
    _taskSubject.sink.add(task);
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
    print('inserted ' + task.title + ' @ row $id');
  }

  void _query() async {
    final allRows = await databaseHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _delete(task) async {
    print("TASK ID: " + task.id.toString());
    final id = await databaseHelper.queryRowCount();
    final rowsDeleted = await databaseHelper.delete(task.id);
    print('deleted $rowsDeleted row: row $id');
  }

  dispose() {
    _taskListSubject.close();
  }
}

final taskBloc = TaskBloc();

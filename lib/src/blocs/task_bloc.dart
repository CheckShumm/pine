import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pine/src/data/task.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc {
  var _tasks = new List<Task>();
  final _taskSubject = BehaviorSubject<List<Task>>();

  getSubject() {
    return _taskSubject;
  }

  getTasks() {
    // _taskSubject.sink.add(_tasks);
    return _tasks;
  }

  updateTasks(title, description, type) {
    this._tasks.add(
        new Task(id: _tasks.length, title: title, description: description, type: type));
    _taskSubject.sink.add(this._tasks);
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

  dispose() {
    _taskSubject.close();
  }
}

final bloc = TaskBloc();

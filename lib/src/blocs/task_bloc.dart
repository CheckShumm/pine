import 'dart:async';
import 'dart:developer';

import 'package:pine/src/data/task.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc {
  var _tasks = <Task>[];
  final _taskSubject = BehaviorSubject<List<Task>>();

  getSubject() {
    return _taskSubject;
  }

  getTasks() async {
    _taskSubject.sink.add(_tasks);
  }

  updateTasks(title, description, type) {
    this._tasks.add(
        new Task(id: _tasks.length, title: title, description: description, type: type));
    _taskSubject.sink.add(this._tasks);
  }

  dispose() {
    _taskSubject.close();
  }
}

final bloc = TaskBloc();

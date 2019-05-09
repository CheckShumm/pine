import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = new TextEditingController();
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 8.0,
        color: Colors.white,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                height: 50,
                child: TextFormField(
                  maxLines: 1,
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: "E.g. Homework",
                    labelText: 'Add a Task',
                    labelStyle: new TextStyle(fontSize: 20.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 42,
                height: 42,
                child: FloatingActionButton(
                    elevation: 4,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[300],
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        bloc.updateTasks(taskController.text, "asd", "type");
                      }
                      FocusScope.of(context).requestFocus(new FocusNode());
                    }, // task bloc update events
                    tooltip: 'Increment',
                    child: Icon(Icons.add)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

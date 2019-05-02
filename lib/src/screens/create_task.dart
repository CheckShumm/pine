import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';

class CreateTaskDialog extends StatefulWidget {
  @override
  _CreateTaskDialogState createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('New Task'),
        ),
        body: new SingleChildScrollView(
            child: Center(
                child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.primaryColorLight,
                        hintText: "Math Homework",
                        hintStyle: new TextStyle(color: theme.primaryColor),
                        labelText: 'Task Title',
                        border: OutlineInputBorder()),
                    controller: titleController,
                  )),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.primaryColorLight,
                          hintText: "Math Homework",
                          hintStyle: new TextStyle(color: theme.primaryColor),
                          labelText: 'Description',
                          border: OutlineInputBorder()),
                      controller: descriptionController)),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.primaryColorLight,
                        hintText: "Math Homework",
                        hintStyle: new TextStyle(color: theme.primaryColor),
                        labelText: 'Type',
                        border: OutlineInputBorder()),
                    controller: typeController,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    print('Add a task');
                    bloc.updateTasks(titleController.text,
                        descriptionController.text, typeController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ))));
  }
}
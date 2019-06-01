import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/database_helper.dart';
import 'package:pine/src/utils/app_constants.dart';

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
    final double width = MediaQuery.of(context).size.width;

    return new AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                Divider(
                  color: theme.primaryColor,
                  height: 4.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "E.g. Math Homework",
                      hintStyle: new TextStyle(color: theme.primaryColor),
                      labelText: 'Task',
                      border: InputBorder.none,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              color: theme.primaryColor,
              height: 4.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextField(
                controller: descriptionController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: "E.g. \nAssignment 3 \nquestions 3-5",
                  hintStyle: new TextStyle(color: theme.primaryColor),
                  labelText: 'Description',
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
            ),
            InkWell(
              onTap: () {
                taskBloc.createTask(titleController.text,
                            defaultDescription, defaultType, -1, primaryColor, defaultIcon);
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0)),
                ),
                child: Text(
                  "Create Task",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

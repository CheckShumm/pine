import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/utils/app_constants.dart';

class CreateTask extends StatefulWidget {
  @required
  final String labeltext;
  @required
  final Icon labelIcon;
  @required
  final onCreate;
  @required
  final bool isSubtask;
  final Task task;

  const CreateTask({Key key, this.labeltext, this.labelIcon, this.onCreate, this.isSubtask, this.task})
      : super(key: key);

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
        shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Container(
                width: 275,
                height: 50,
                child: TextField(
                  maxLines: 1,
                  controller: taskController,
                  decoration: InputDecoration(
                    icon: widget.labelIcon,
                    hintText: "E.g. Homework",
                    hintStyle: TextStyle(fontSize: 18.0),
                    labelText: widget.labeltext,
                    labelStyle: new TextStyle(fontSize: 20.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                    elevation: 6,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[300],
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        if(!widget.isSubtask) {
                        taskBloc.createTask(taskController.text,
                            defaultDescription, defaultType, -1, primaryColor, defaultIcon);
                        } else {
                          taskBloc.addSubTask(taskController.text, widget.task);
                        }
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

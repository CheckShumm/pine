import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/utils/icon_constants.dart';

class IconDropdown extends StatefulWidget {
  @required
  final Task task;
  @required
  final void onChanged;


  IconDropdown({Key key, this.task, this.onChanged}) : super(key: key);

  @override
  _IconDropdownState createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: iconContainer(Icon(widget.task.iconData, color: Colors.white)),
      elevation: 0,
      items:
          icons.keys.map<DropdownMenuItem<String>>((String iconString) {
        return DropdownMenuItem<String>(
            value: iconString,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: iconContainer(Icon(icons[iconString], color: Colors.white))));
      }).toList(),
      onChanged: (value) {
        taskBloc.setTaskIcon(widget.task, value);
      },
    );
  }

  iconContainer(Icon icon) {
    return Container(
        width: 32.0,
        height: 32.0,
        decoration: new BoxDecoration(
          color: widget.task.color,
          shape: BoxShape.circle,
        ),
        child: icon);
  }
}

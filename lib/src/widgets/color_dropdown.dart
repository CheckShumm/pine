import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/utils/color_constants.dart';

class ColorDropDown extends StatefulWidget {
  @required
  final Task task;
  @required
  final void onChanged;

  ColorDropDown({this.task, this.onChanged});

  @override
  _ColorDropDownState createState() => _ColorDropDownState();
}

class _ColorDropDownState extends State<ColorDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: colorCircle(widget.task.color),
      items:
          colors.keys.map<DropdownMenuItem<String>>((String colorString) {
        return DropdownMenuItem<String>(
            value: colorString,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: colorCircle(colors[colorString])));
      }).toList(),
      onChanged: (value) {
        taskBloc.setTaskColor(widget.task, value);
        FlutterStatusbarcolor.setStatusBarColor(widget.task.color);
      },
    );
  }

  colorCircle(Color color) {
    return Container(
        width: 32.0,
        height: 32.0,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ));
  }
}

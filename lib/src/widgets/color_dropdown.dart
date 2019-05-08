import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';

class ColorDropDown extends StatefulWidget {
  @required
  final Task task;
  @required
  final void onChanged;

  final Map<String, Color> colors = {
    "Red": Colors.red,
    "Orange": Colors.orange,
    "Yellow": Colors.yellow,
    "Green": Colors.green,
    "Blue": Colors.blue,
    "Indigo": Colors.indigo,
    "Purple": Colors.purple,
    "Pink": Colors.pink
  };

  ColorDropDown({this.task, this.onChanged});

  @override
  _ColorDropDownState createState() => _ColorDropDownState();
}

class _ColorDropDownState extends State<ColorDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: colorCircle(widget.task.color),
      elevation: 8,
      items:
          widget.colors.keys.map<DropdownMenuItem<Color>>((String colorString) {
        return DropdownMenuItem<Color>(
            value: widget.colors[colorString],
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: colorCircle(widget.colors[colorString])));
      }).toList(),
      onChanged: (value) {
        bloc.setTaskColor(widget.task.index, value);
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

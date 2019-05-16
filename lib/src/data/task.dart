import 'package:flutter/material.dart';

class Task {
  int id;
  int index;
  String title;
  String description;
  IconData iconData;
  String type;
  Color color = Colors.green;
  List<String> subtasks;

  Task(
      {this.id,
      this.index,
      this.title,
      this.description,
      this.type,
      this.color,
      this.iconData,
      this.subtasks});


  setID(int id) {
    this.id = id;
  }

  setColor(Color color) {
    this.color = color;
  }

  setIndex(int index) {
    this.index = index;
  }

  setIconData(IconData iconData) {
    this.iconData = iconData;
  }
}

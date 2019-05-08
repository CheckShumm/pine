import 'package:flutter/material.dart';

class Task {

  int id;
  int index;
  String title;
  String description;
  String type;
  Color color = Colors.green;

  Task({this.id, this.index, this.title, this.description, this.type, this.color});

  setColor(Color color) {
    this.color = color;
  }

  setIndex(int index) {
    this.index = index;
  }
}

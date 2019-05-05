import 'package:flutter/material.dart';

class Task {

  int id;
  String title;
  String description;
  String type;
  Color color;

  Task({this.id, this.title, this.description, this.type, this.color});

  setColor(Color color) {
    this.color = color;
  }
}

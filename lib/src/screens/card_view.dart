import 'package:flutter/material.dart';
import 'package:pine/src/blocs/task_bloc.dart';
import 'package:pine/src/data/task.dart';
import 'package:pine/src/widgets/card_list_view.dart';

class CardView extends StatefulWidget {
  final String title;

  CardView({this.title});

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<List<Task>>(
        stream: bloc.getSubject().stream,
        builder: (context, snapshot) => taskList(snapshot.data));
  }

  Widget taskList(List<Task> data) {
    if (bloc.getTasks().isEmpty) {
      return Text('Get ready for tomorrow, \nAdd some tasks!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 24.0));
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: _buildTask(data),
      );
    }
  }
  
  Widget _buildTask(List<Task> taskList) {
    return  CardListView(cardList: taskList);
  }
}

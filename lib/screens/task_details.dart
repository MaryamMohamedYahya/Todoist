import 'package:flutter/material.dart';
import 'package:todoist/models/task.dart';

class TaskDetails extends StatelessWidget {
  final Tasks task;
  const TaskDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(task.description),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import '../../data/blocs/blocs.dart';
import '../pages.dart';

class TaskTileWidget extends StatelessWidget {
  final TaskBloc taskBloc;
  final TaskModel task;

  const TaskTileWidget({required this.taskBloc, required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (bool? value) => taskBloc.add(
          UpdateTask(
            task: task.copyWith(isDone: !task.isDone),
          ),
        ),
      ),
      title: Text(task.title),
      subtitle: task.details.trim().isNotEmpty ? Text(task.details) : null,
      trailing: IconButton(
        icon: const Icon(
          Icons.remove_circle,
          color: Colors.red,
        ),
        onPressed: () => taskBloc.add(
          RemoveTask(task: task),
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TaskEditPage(
            taskBloc: taskBloc,
            task: task,
          ),
        ),
      ),
    );
  }
}

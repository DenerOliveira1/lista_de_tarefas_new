import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../data/models/models.dart';
import '../data/stores/stores.dart';
import '../data/blocs/blocs.dart';
import './widgets/widgets.dart';

class TaskEditPage extends StatefulWidget {
  final TaskBloc taskBloc;
  final TaskModel? task;

  const TaskEditPage({required this.taskBloc, this.task, super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  late final TaskStore _taskStore;

  @override
  void initState() {
    super.initState();

    _taskStore = TaskStore(taskBloc: widget.taskBloc, task: widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_taskStore.id == null ? 'Adicionar tarefa' : ' Editar tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskTitleWidget(_taskStore),
            TaskDetailsWidget(_taskStore),
            TaskDoneWidget(_taskStore),
          ],
        ),
      ),
      persistentFooterButtons: [
        Observer(
          builder: (context) {
            return ElevatedButton(
              onPressed: _taskStore.editPressed,
              child: const Text('Salvar'),
            );
          },
        ),
      ],
    );
  }
}

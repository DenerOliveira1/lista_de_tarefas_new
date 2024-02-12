import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

import '../../data/stores/stores.dart';

class TaskDoneWidget extends StatelessWidget {
  final TaskStore taskStore;

  const TaskDoneWidget(this.taskStore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return CheckboxListTile(
          value: taskStore.isDone,
          onChanged: taskStore.setIsDone,
          title: const Text('Concluída?'),
        );
      },
    );
  }
}

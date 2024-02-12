import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

import '../../data/stores/stores.dart';

class TaskTitleWidget extends StatelessWidget {
  final TaskStore taskStore;

  const TaskTitleWidget(this.taskStore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Observer(
        builder: (context) {
          return TextFormField(
            initialValue: taskStore.title,
            onChanged: taskStore.setTitle,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Título',
              errorText: taskStore.titleError,
            ),
          );
        }
      ),
    );
  }
}

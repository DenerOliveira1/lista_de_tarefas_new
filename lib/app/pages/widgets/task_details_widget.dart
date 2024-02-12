import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/stores/stores.dart';

class TaskDetailsWidget extends StatelessWidget {
  final TaskStore taskStore;

  const TaskDetailsWidget(this.taskStore, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Observer(
        builder: (context) {
          return TextFormField(
            initialValue: taskStore.details,
            maxLines: 5,
            onChanged: taskStore.setDetails,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Detalhes',
            ),
          );
        },
      ),
    );
  }
}

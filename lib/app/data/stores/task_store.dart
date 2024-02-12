import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/models.dart';
import '../blocs/blocs.dart';

part 'task_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {
  late final TaskBloc _taskBloc;

  TaskStoreBase({required TaskBloc taskBloc, TaskModel? task}) {
    _taskBloc = taskBloc;

    if (task != null) {
      id = task.id;
      title = task.title;
      details = task.details;
      isDone = task.isDone;
    }
  }

  @observable
  String? id;

  @observable
  String title = '';

  @observable
  String details = '';

  @observable
  bool isDone = false;

  @action
  void setTitle(String value) => title = value;

  @action
  void setDetails(String value) => details = value;

  @action
  void setIsDone(bool? value) => isDone = value ?? false;

  bool get titleValid {
    return title.trim().isNotEmpty;
  }

  @computed
  String? get titleError {
    if (titleValid) {
      return null;
    } else {
      return 'Título inválido';
    }
  }

  @computed
  bool get isFormValid {
    return titleValid;
  }

  @computed
  VoidCallback? get editPressed {
    return isFormValid ? _edit : null;
  }

  @action
  Future<void> _edit() async {
    if (id == null) {
      _taskBloc.add(
        AddTask(
          task: TaskModel(
            id: DateTime.now().toIso8601String(),
            title: title,
            details: details,
            isDone: isDone,
          ),
        ),
      );
    } else {
      _taskBloc.add(
        UpdateTask(
          task: TaskModel(
            id: id!,
            title: title,
            details: details,
            isDone: isDone,
          ),
        ),
      );
    }
  }
}

import '../models/models.dart';

abstract class TaskEvent {}

class GetTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;

  AddTask({required this.task});
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  UpdateTask({required this.task});
}

class RemoveTask extends TaskEvent {
  final TaskModel task;

  RemoveTask({required this.task});
}
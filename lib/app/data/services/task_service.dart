import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class TaskService {
  final String _tasksKey = "tasks";
  SharedPreferences? _prefs;

  TaskService() {
    SharedPreferences.getInstance().then((value) => _prefs);
  }

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) {
      return _prefs!;
    } else {
      _prefs = await SharedPreferences.getInstance();
      return _prefs!;
    }
  }

  Future<List<TaskModel>> getTasks() async {
    List<String> tasksString = await prefs.then((value) => value.getStringList(_tasksKey)) ?? [];

    List<TaskModel> tasks = [];

    for (String task in tasksString) {
      tasks.add(TaskModel.fromString(task));
    }

    return tasks;
  }

  Future<void> addTask({required TaskModel task}) async {
    List<TaskModel> tasks = await getTasks();
    List<String> tasksString = _listModelToListString(tasks);

    tasksString.add(task.toString());

    return await _saveTasks(tasksString);
  }

  Future<void> updateTask({required TaskModel task}) async {
    List<TaskModel> tasks = await getTasks();

    int index = tasks.indexWhere((element) => element.id == task.id);

    tasks[index] = task;

    List<String> tasksString = _listModelToListString(tasks);

    return await _saveTasks(tasksString);
  }

  Future<void> removeTask({required TaskModel task}) async {
    List<TaskModel> tasks = await getTasks();
    List<String> tasksString = _listModelToListString(tasks);

    tasksString.remove(task.toString());

    return await _saveTasks(tasksString);
  }

  List<String> _listModelToListString(List<TaskModel> tasks) {
    List<String> tasksString = [];

    for (TaskModel model in tasks) {
      tasksString.add(model.toString());
    }

    return tasksString;
  }

  Future<void> _saveTasks(List<String> tasksString) async {
    return prefs.then(
      (value) => value.setStringList(
        _tasksKey,
        tasksString,
      ),
    );
  }
}

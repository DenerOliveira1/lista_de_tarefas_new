import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_tarefas_new/app/data/services/services.dart';
import 'package:lista_de_tarefas_new/app/data/models/models.dart';

void main() {
  group('Verifica a inicialização do serviço', () {
    late final TaskService taskService;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskService = TaskService();
    });

    test('Testa se iniciou o SharedPreferences corretamente', () => expectLater(taskService.prefs, isNotNull));
  });

  group('Testes das ações do CRUD', () {
    late final TaskService taskService;

    setUpAll(() {
      SharedPreferences.setMockInitialValues({});

      taskService = TaskService();
    });

    test('Teste de inclusão de uma tarefa', () async {
      List<TaskModel> tasks = await taskService.getTasks();

      /// Garante que a lista de tarefas está vazia
      expect(tasks, isEmpty);

      TaskModel task = TaskModel(
        id: DateTime.now().toIso8601String(),
        title: 'título',
        details: 'detalhes',
        isDone: true,
      );

      await taskService.addTask(task: task);

      tasks = await taskService.getTasks();

      /// Garante que a lista de tarefas está vazia
      expect(tasks, isNotEmpty);
    });

    test('Teste de update de uma tarefa', () async {
      TaskModel task = TaskModel(
        id: DateTime.now().toIso8601String(),
        title: 'título',
        details: 'detalhes',
        isDone: true,
      );

      await taskService.addTask(task: task);

      var tasks = await taskService.getTasks();

      expect(tasks.any((element) => element.id == task.id), isTrue);

      await taskService.updateTask(task: task.copyWith(title: 'título 1'));

      tasks = await taskService.getTasks();

      expect(tasks.any((element) => element.title == 'título 1'), isTrue);
    });

    test('Teste de remoção de uma tarefa', () async {
      TaskModel task = TaskModel(
        id: DateTime.now().toIso8601String(),
        title: 'título',
        details: 'detalhes',
        isDone: true,
      );

      await taskService.addTask(task: task);

      var tasks = await taskService.getTasks();

      expect(tasks.firstWhere((element) => element.id == task.id).id, task.id);

      await taskService.removeTask(task: task);

      tasks = await taskService.getTasks();

      expect(tasks.any((element) => element.id == task.id), isFalse);
    });
  });
}